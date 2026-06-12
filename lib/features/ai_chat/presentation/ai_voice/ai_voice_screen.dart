import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:memo/core/chat/chat_state.dart';
import 'package:memo/features/ai_chat/cubits/ai_chat_cubit.dart';
import 'package:memo/features/ai_chat/presentation/ai_voice/widgets/premission_bar.dart';
import 'package:memo/features/ai_chat/presentation/ai_voice/widgets/voice_orb.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import 'widgets/voice_screen_app_bar.dart';
import 'widgets/status_label.dart';
import 'widgets/transcript_card.dart';

class AiVoiceScreen extends StatefulWidget {
  const AiVoiceScreen({super.key});

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
  String _transcribedText = '';
  String _statusMessage = 'Tap the mic to speak';

  // ── Text to Speech ──────────────────────────────────────
  final FlutterTts _tts = FlutterTts();

  // Tracks the last spoken AI message to avoid re-speaking
  // the same text on every streaming chunk emit from the cubit
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
    context.read<AiChatCubit>().connect(1);
  }

  @override
  void dispose() {
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
        setState(() {
          _isListening = false;
          _statusMessage = 'Error: ${error.errorMsg}';
        });
      },
    );
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
        _statusMessage = 'Tap the mic to speak';
      });
    });

    _tts.setErrorHandler((msg) {
      if (!mounted) return;
      setState(() {
        _isSpeaking = false;
        _statusMessage = 'Tap the mic to speak';
      });
    });
  }

  // ── STT status callback ──────────────────────────────────
  void _onSpeechStatus(String status) {
    if (status == 'done' || status == 'notListening') {
      if (_isListening) {
        setState(() {
          _isListening = false;
          _statusMessage = 'Processing…';
          _isProcessing = true;
        });
        _sendToAi(_transcribedText);
      }
    }
  }

  // ── STT result callback ──────────────────────────────────
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() => _transcribedText = result.recognizedWords);

    if (result.finalResult && _transcribedText.isNotEmpty) {
      _speech.stop();
      setState(() {
        _isListening = false;
        _statusMessage = 'Processing…';
        _isProcessing = true;
      });
      _sendToAi(_transcribedText);
    }
  }

  // ── Toggle mic ───────────────────────────────────────────
  Future<void> _toggleListening() async {
    if (!_isAvailable) return;

    // Tapping while TTS is speaking → stop speech so user can talk again
    if (_isSpeaking) {
      await _tts.stop();
      setState(() {
        _isSpeaking = false;
        _statusMessage = 'Tap the mic to speak';
      });
      return;
    }

    if (_isListening) {
      await _speech.stop();
      setState(() {
        _isListening = false;
        _statusMessage = 'Stopped';
      });
    } else {
      setState(() {
        _transcribedText = '';
        _isListening = true;
        _isProcessing = false;
        _lastSpokenAiMessage = '';
        _statusMessage = 'Listening…';
      });

      await _speech.listen(
        onResult: _onSpeechResult,
        listenFor: const Duration(seconds: 30),
        pauseFor: const Duration(seconds: 3),
        partialResults: true,
        localeId: 'en_US',
        listenMode: ListenMode.confirmation,
      );
    }
  }

  // ── sendToAi → delegates to AiChatCubit ─────────────────
  void _sendToAi(String text) {
    if (text.trim().isEmpty) {
      setState(() {
        _isProcessing = false;
        _statusMessage = 'Tap the mic to speak';
      });
      return;
    }

    context.read<AiChatCubit>().sendMessage(text);

    setState(() {
      _transcribedText = '';
      _isProcessing = true;
      _statusMessage = 'Processing…';
    });
  }

  // ── Speak AI response via TTS ────────────────────────────
  // Only called once the cubit signals the stream is complete
  // (status flips from "answering" → "connected")
  Future<void> _speakAiResponse(String text) async {
    if (text.isEmpty || text == _lastSpokenAiMessage) return;
    _lastSpokenAiMessage = text;
    await _tts.stop();
    await _tts.speak(text);
  }

  // ── Build ─────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return BlocListener<AiChatCubit, ChatState>(
      // Listen to cubit state changes to know when AI finishes streaming
      listener: (context, state) {
        // cubit emits "answering" while streaming chunks arrive,
        // then flips back to "connected" when the stream is done.
        // That transition is the signal to speak the full response.
        if (state.status == ChatConnectionStatus.connected &&
            state.messages.isNotEmpty &&
            !state.messages.last.isMe) {
          _speakAiResponse(state.messages.last.message);
          setState(() => _isProcessing = false);
        }

        if (state.status == ChatConnectionStatus.error) {
          setState(() {
            _isProcessing = false;
            _statusMessage = 'Error — tap to retry';
          });
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF1F1F1F),
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
                    TranscriptCard(text: _transcribedText),
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
