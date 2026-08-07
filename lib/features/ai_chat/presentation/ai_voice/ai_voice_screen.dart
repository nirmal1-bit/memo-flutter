import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:memo/core/chat/chat_state.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/features/ai_chat/cubits/ai_chat_cubit.dart';
import 'package:memo/features/ai_chat/presentation/ai_voice/widgets/premission_bar.dart';
import 'package:memo/features/ai_chat/presentation/ai_voice/widgets/voice_orb.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import 'widgets/voice_screen_app_bar.dart';
import 'widgets/status_label.dart';
import 'widgets/transcript_card.dart';

class AiVoiceScreen extends StatefulWidget {
  const AiVoiceScreen({super.key, required this.connectionId});
  final int connectionId;

  @override
  State<AiVoiceScreen> createState() => _AiVoiceScreenState();
}

class _AiVoiceScreenState extends State<AiVoiceScreen>
    with TickerProviderStateMixin {
  // ── Speech to Text ──────────────────────────────────────
  final SpeechToText _speech = SpeechToText();

  bool _isAvailable = false;
  bool _isListening = false;
  bool _isProcessing = false;
  bool _isSpeaking = false;
  // Speech recognition can report one utterance through both onResult and
  // onStatus. Keep this separate from _isProcessing because the cubit may
  // briefly emit "connected" when the first websocket chunk arrives.
  bool _requestInFlight = false;
  String _transcribedText = '';
  String _aiResponseText = '';
  String _statusMessage = 'Tap the mic to speak';
  Timer? _responseDebounce;

  // ── Text to Speech ──────────────────────────────────────
  final FlutterTts _tts = FlutterTts();

  // Tracks the complete response already handed to TTS.
  String _lastSpokenAiMessage = '';

  // ── Animations ───────────────────────────────────────────
  late AnimationController _pulseController;
  late AnimationController _rotationController;
  late Animation<double> _pulseAnim;

  // ── Lifecycle ────────────────────────────────────────────
  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();

    _pulseAnim = Tween<double>(begin: 1.0, end: 1.18).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _initSpeech();
    _initTts();
    context.read<AiChatCubit>().connect(widget.connectionId);
  }

  @override
  void dispose() {
    _responseDebounce?.cancel();
    _pulseController.dispose();
    _rotationController.dispose();
    _speech.stop();
    _tts.stop();
    super.dispose();
  }

  // ── STT init ─────────────────────────────────────────────
  Future<void> _initSpeech() async {
    _isAvailable = await _speech.initialize(
      onStatus: _onSpeechStatus,
      onError: (error) {
        if (!mounted) return;
        setState(() {
          _isListening = false;
          _statusMessage = 'Error: ${error.errorMsg}';
        });
      },
    );
    if (!mounted) return;
    setState(() {});
  }

  // ── TTS init ─────────────────────────────────────────────
  Future<void> _initTts() async {
    await _tts.setLanguage('en-US');
    await _tts.setSpeechRate(0.5);
    await _tts.setVolume(1.0);
    await _tts.setPitch(1.0);

    _tts.setStartHandler(() {
      if (!mounted) return;
      setState(() {
        _isSpeaking = true;
        _statusMessage = 'Speaking…';
      });
    });

    _tts.setCompletionHandler(() {
      if (!mounted) return;
      setState(() {
        _isSpeaking = false;
        _isProcessing = false;
        _requestInFlight = false;
        _responseDebounce?.cancel();
        _statusMessage = 'Tap the mic to speak';
      });
    });

    _tts.setErrorHandler((msg) {
      if (!mounted) return;
      setState(() {
        _isSpeaking = false;
        _isProcessing = false;
        _requestInFlight = false;
        _statusMessage = 'Tap the mic to speak';
      });
    });
  }

  // ── STT status callback ──────────────────────────────────
  void _onSpeechStatus(String status) {
    if (!mounted) return;

    if (status == 'done' || status == 'notListening') {
      _finishListeningAndSend();
    }
  }

  // ── STT result callback ──────────────────────────────────
  void _onSpeechResult(SpeechRecognitionResult result) {
    if (!mounted) return;

    setState(() => _transcribedText = result.recognizedWords);

    if (result.finalResult) {
      _finishListeningAndSend();
    }
  }

  void _finishListeningAndSend() {
    if (!mounted) return;

    // onResult(finalResult) and onStatus(done) may both arrive for the same
    // utterance. Only the first callback is allowed to create a request.
    if (!_isListening || _requestInFlight) return;

    _isListening = false;
    _speech.stop();
    _sendToAi(_transcribedText);
  }

  // ── Toggle mic ───────────────────────────────────────────
  Future<void> _toggleListening() async {
    if (!_isAvailable) return;

    // Tapping while TTS is speaking → stop speech so user can talk again
    if (_isSpeaking) {
      await _tts.stop();
      if (!mounted) return;
      setState(() {
        _isSpeaking = false;
        _isProcessing = false;
        _requestInFlight = false;
        _statusMessage = 'Tap the mic to speak';
      });
      return;
    }

    // Do not start a new recognition session while the previous request is
    // waiting for its response or being spoken.
    if (_isProcessing || _requestInFlight) return;

    if (_isListening) {
      await _speech.stop();
      if (!mounted) return;
      setState(() {
        _isListening = false;
        _statusMessage = 'Stopped';
      });
    } else {
      setState(() {
        _transcribedText = '';
        _isListening = true;
        _isProcessing = false;
        _requestInFlight = false;
        _aiResponseText = '';
        _lastSpokenAiMessage = '';
        _responseDebounce?.cancel();
        _statusMessage = 'Listening…';
      });

      await _speech.listen(
        onResult: _onSpeechResult,
        listenFor: const Duration(seconds: 30),
        pauseFor: const Duration(seconds: 3),
        localeId: 'en_US',
        listenOptions: SpeechListenOptions(
          partialResults: true,
          listenMode: ListenMode.confirmation,
        ),
      );
      if (!mounted) return;
    }
  }

  // ── sendToAi → delegates to AiChatCubit ─────────────────
  void _sendToAi(String text) {
    if (_requestInFlight) return;

    if (text.trim().isEmpty) {
      setState(() {
        _isListening = false;
        _isProcessing = false;
        _statusMessage = 'Tap the mic to speak';
      });
      return;
    }

    _requestInFlight = true;
    _responseDebounce?.cancel();
    _lastSpokenAiMessage = '';
    setState(() {
      _isListening = false;
      _isProcessing = true;
      _statusMessage = 'Processing…';
    });

    context.read<AiChatCubit>().sendMessage(
      "$text Extra Instruction: answer in plain text no markdown required as your response is being read out loud by a text to speech engine and markdown formatting will not be read correctly. Also keep the response concise and to the point.",
    );
  }

  // ── Speak AI response via TTS ────────────────────────────
  // The websocket currently sends plain-text chunks without a completion
  // marker. Wait until the stream has been quiet briefly, then read the
  // complete message accumulated by AiChatCubit.
  void _scheduleResponseSpeech() {
    _responseDebounce?.cancel();
    _responseDebounce = Timer(const Duration(milliseconds: 700), () {
      if (!mounted || !_requestInFlight) return;

      final messages = context.read<AiChatCubit>().state.messages;
      if (messages.isEmpty || messages.last.isMe) return;

      _speakAiResponse(messages.last.message);
    });
  }

  Future<void> _speakAiResponse(String text) async {
    if (text.isEmpty || text == _lastSpokenAiMessage) return;
    _lastSpokenAiMessage = text;
    if (_isSpeaking) {
      await _tts.stop();
    }
    if (!mounted) return;
    await _tts.speak(text);
  }

  // ── Build ─────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return BlocListener<AiChatCubit, ChatState>(
      listener: (context, state) {
        if (_requestInFlight &&
            state.messages.isNotEmpty &&
            !state.messages.last.isMe) {
          if (_aiResponseText != state.messages.last.message) {
            setState(() {
              _aiResponseText = state.messages.last.message;
            });
          }
          _scheduleResponseSpeech();
        }

        if (state.status == ChatConnectionStatus.error) {
          _responseDebounce?.cancel();
          setState(() {
            _isProcessing = false;
            _requestInFlight = false;
            _statusMessage = 'Error — tap to retry';
          });
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.black,
        body: SafeArea(
          child: Column(
            children: [
              const VoiceScreenAppBar(),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(flex: 2),
                    VoiceOrb(
                      isListening: _isListening,
                      // treat both "waiting for AI" and "TTS speaking"
                      // as the processing/active state for the orb
                      isProcessing: _isProcessing || _isSpeaking,
                      pulseAnim: _pulseAnim,
                      rotationController: _rotationController,
                      onTap: _toggleListening,
                    ),
                    const SizedBox(height: 32),
                    StatusLabel(
                      message: _statusMessage,
                      isListening: _isListening,
                      isProcessing: _isProcessing || _isSpeaking,
                    ),
                    const SizedBox(height: 24),
                    TranscriptCard(
                      text: _transcribedText,
                      aiText: _aiResponseText,
                    ),
                    const Spacer(flex: 3),
                    if (!_isAvailable) const PermissionBanner(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
