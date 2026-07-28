import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/theme/app_text_styles.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

enum _Status {
  noFace,
  tooFar,
  tooClose,
  moveLeft,
  moveRight,
  moveUp,
  moveDown,
  good,
}

const _icons = {
  _Status.noFace: Icons.face_retouching_off,
  _Status.tooFar: Icons.zoom_in,
  _Status.tooClose: Icons.zoom_out,
  _Status.moveLeft: Icons.arrow_back,
  _Status.moveRight: Icons.arrow_forward,
  _Status.moveUp: Icons.arrow_upward,
  _Status.moveDown: Icons.arrow_downward,
  _Status.good: Icons.face,
};

const _messages = {
  _Status.noFace: 'Position your face inside the frame',
  _Status.tooFar: 'Move closer',
  _Status.tooClose: 'Move a little further away',
  _Status.moveLeft: 'Move slightly to your left',
  _Status.moveRight: 'Move slightly to your right',
  _Status.moveUp: 'Move up a little',
  _Status.moveDown: 'Move down a little',
  _Status.good: 'Hold still…',
};

Rect _ovalRect(Size s) {
  final w = s.width * 0.78;
  return Rect.fromCenter(
    center: Offset(s.width / 2, s.height * 0.46),
    width: w,
    height: w * 1.25,
  );
}

class FaceVerificationScreen extends StatefulWidget {
  const FaceVerificationScreen({super.key, this.onImageCaptured});

  final ValueChanged<File>? onImageCaptured;
  @override
  State<FaceVerificationScreen> createState() => _State();
}

class _State extends State<FaceVerificationScreen>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  CameraController? _cam;
  final _detector = FaceDetector(
    options: FaceDetectorOptions(
      performanceMode: FaceDetectorMode.fast,
      enableTracking: true,
      minFaceSize: 0.12,
    ),
  );
  late final AnimationController _scan = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  )..repeat(reverse: true);
  // Drives the progress ring. We animateTo() the target value instead of
  // rebuilding a fresh Tween each frame, so it eases smoothly from wherever
  // it currently is rather than snapping back to 0 on every setState.
  late final AnimationController _ring = AnimationController(vsync: this);

  _Status _status = _Status.noFace;
  int _streak = 0;
  bool _detecting = false, _capturing = false;
  bool _checking = true, _granted = false, _permDenied = false, _error = false;
  File? _captured;

  static const _needed = 10;
  static const _tooFar = 0.10, _tooClose = 0.60, _center = 0.20;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _init();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _cam?.dispose();
    _detector.close();
    _scan.dispose();
    _ring.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState s) {
    if (_cam == null || !_cam!.value.isInitialized) return;
    if (s == AppLifecycleState.inactive) _cam!.stopImageStream();
    if (s == AppLifecycleState.resumed) _granted ? _startCamera() : _init();
  }

  Future<void> _init() async {
    setState(() {
      _checking = true;
      _permDenied = false;
    });
    var s = await Permission.camera.status;
    if (!s.isGranted) s = await Permission.camera.request();
    if (!mounted) return;
    setState(() {
      _granted = s.isGranted;
      _permDenied = s.isPermanentlyDenied || s.isRestricted;
      _checking = false;
    });
    if (s.isGranted) await _startCamera();
  }

  Future<void> _startCamera() async {
    try {
      final cams = await availableCameras();
      final front = cams.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.front,
        orElse: () => cams.first,
      );
      final ctrl = CameraController(
        front,
        ResolutionPreset.medium,
        enableAudio: false,
        imageFormatGroup: Platform.isAndroid
            ? ImageFormatGroup.nv21
            : ImageFormatGroup.bgra8888,
      );
      await ctrl.initialize();
      if (!mounted) return;
      _cam = ctrl;
      setState(() {});
      ctrl.startImageStream(_onFrame);
    } catch (_) {
      if (mounted) setState(() => _error = true);
    }
  }

  Future<void> _onFrame(CameraImage img) async {
    if (_detecting || _capturing) return;
    _detecting = true;
    try {
      final cam = _cam?.description;
      if (cam == null) return;
      final bytes = BytesBuilder()
        ..add(img.planes.expand((p) => p.bytes).toList());
      final input = InputImage.fromBytes(
        bytes: bytes.toBytes(),
        metadata: InputImageMetadata(
          size: Size(img.width.toDouble(), img.height.toDouble()),
          rotation:
              InputImageRotationValue.fromRawValue(cam.sensorOrientation) ??
              InputImageRotation.rotation0deg,
          format:
              InputImageFormatValue.fromRawValue(img.format.raw) ??
              (Platform.isAndroid
                  ? InputImageFormat.nv21
                  : InputImageFormat.bgra8888),
          bytesPerRow: img.planes.first.bytesPerRow,
        ),
      );
      final faces = await _detector.processImage(input);
      if (!mounted) return;
      if (faces.isEmpty) {
        _set(_Status.noFace);
        _resetStreak();
        return;
      }
      final box = faces.first.boundingBox;
      final iw = img.width.toDouble(), ih = img.height.toDouble();
      final area = (box.width * box.height) / (iw * ih);
      final dx = (box.center.dx - iw / 2) / iw;
      final dy = (box.center.dy - ih / 2) / ih;
      final status = area < _tooFar
          ? _Status.tooFar
          : area > _tooClose
          ? _Status.tooClose
          : dx.abs() > _center
          ? (dx > 0 ? _Status.moveLeft : _Status.moveRight)
          : dy.abs() > _center
          ? (dy > 0 ? _Status.moveUp : _Status.moveDown)
          : _Status.good;
      _set(status);
      if (status != _Status.good) {
        _resetStreak();
        return;
      }
      _streak++;
      _ring.animateTo(
        (_streak / _needed).clamp(0.0, 1.0),
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
      );
      if (_streak >= _needed) {
        _streak = 0;
        await _capture();
      }
    } finally {
      _detecting = false;
    }
  }

  void _resetStreak() {
    if (_streak == 0) return;
    _streak = 0;
    _ring.animateTo(0, duration: const Duration(milliseconds: 150));
  }

  void _set(_Status s) {
    if (s != _status) setState(() => _status = s);
  }

  Future<void> _capture() async {
    final ctrl = _cam;
    if (ctrl == null || !ctrl.value.isInitialized || _capturing) return;
    setState(() => _capturing = true);
    try {
      await ctrl.stopImageStream();
      final pic = await ctrl.takePicture();
      final dir = await getTemporaryDirectory();
      final file = await File(
        pic.path,
      ).copy('${dir.path}/face_${DateTime.now().millisecondsSinceEpoch}.jpg');
      if (!mounted) return;
      setState(() {
        _captured = file;
        _capturing = false;
      });

      // The login flow supplies this callback and must continue immediately
      // after a valid frame is captured. Other uses of this screen can omit it.
      widget.onImageCaptured?.call(file);
    } catch (_) {
      if (mounted) {
        setState(() => _capturing = false);
        ctrl.startImageStream(_onFrame);
      }
    }
  }

  Color get _color => _status == _Status.good
      ? AppColors.statusGreen
      : _status == _Status.noFace
      ? AppColors.textLight
      : AppColors.statusOrange;

  @override
  Widget build(BuildContext context) => Container(
    color: AppColors.black,
    child: LayoutBuilder(builder: (_, c) => _body(c.biggest)),
  );

  Widget _body(Size size) {
    if (_checking) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      );
    }
    if (!_granted) {
      return _infoScreen(
        icon: Icons.camera_alt_outlined,
        msg: _permDenied
            ? 'Camera access is permanently denied.\nEnable it in device settings.'
            : 'Camera access is needed.\nPlease grant permission to continue.',
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.buttonPrimary,
            ),
            onPressed: _permDenied ? openAppSettings : _init,
            child: Text(_permDenied ? 'Open Settings' : 'Grant Permission'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).maybePop(),
            child: Text(
              'Cancel',
              style: AppTextStyles.rubik.copyWith(color: AppColors.textLight),
            ),
          ),
        ],
      );
    }
    if (_error) {
      return _infoScreen(
        icon: Icons.videocam_off,
        msg: 'Could not access the camera.\nPlease try again.',
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.buttonPrimary,
            ),
            onPressed: () {
              setState(() => _error = false);
              _init();
            },
            child: const Text('Retry'),
          ),
        ],
      );
    }
    if (_captured != null) return _postCapture(size);
    if (_cam == null || !_cam!.value.isInitialized) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      );
    }
    return _preview(size);
  }

  Widget _infoScreen({
    required IconData icon,
    required String msg,
    required List<Widget> actions,
  }) => Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.white, size: 48),
          const SizedBox(height: 16),
          Text(
            msg,
            textAlign: TextAlign.center,
            style: AppTextStyles.rubik.copyWith(color: AppColors.white),
          ),
          const SizedBox(height: 20),
          ...actions,
        ],
      ),
    ),
  );

  Widget _sweepLine(Rect oval, Color color, {double opacity = 0.95}) =>
      AnimatedBuilder(
        animation: _scan,
        builder: (_, _) => ClipPath(
          clipper: _OvalClipper(oval),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                top: oval.top + _scan.value * oval.height - 1.5,
                left: oval.left,
                width: oval.width,
                child: Container(
                  height: 3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    gradient: LinearGradient(
                      colors: [
                        color.withOpacity(0),
                        color.withOpacity(opacity),
                        color.withOpacity(0),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: color.withOpacity(0.7),
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  // Static oval outline with no scanning animation — used once a photo has
  // been captured, since the sweep only makes sense while actively scanning.
  Widget _postCapture(Size size) {
    final oval = _ovalRect(size);
    return Stack(
      fit: StackFit.expand,
      children: [
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(3.14159),
          child: Image.file(_captured!, fit: BoxFit.cover),
        ),
        Container(color: AppColors.black.withOpacity(0.35)),
        CustomPaint(
          painter: _OvalPainter(oval: oval, color: AppColors.primary),
        ),
      ],
    );
  }

  Widget _preview(Size size) {
    final oval = _ovalRect(size);
    final isGood = _status == _Status.good;
    return Stack(
      fit: StackFit.expand,
      children: [
        Center(
          child: AspectRatio(
            aspectRatio: 1 / _cam!.value.aspectRatio,
            child: CameraPreview(_cam!),
          ),
        ),
        CustomPaint(
          size: size,
          painter: _OvalPainter(oval: oval, color: _color, scrim: true),
        ),
        _sweepLine(
          oval,
          isGood ? AppColors.statusGreen : AppColors.primary,
          opacity: _status != _Status.noFace ? 0.95 : 0.5,
        ),
        Positioned.fromRect(
          rect: oval.inflate(8),
          child: AnimatedBuilder(
            animation: _ring,
            builder: (_, _) => CustomPaint(
              painter: _RingPainter(_ring.value, AppColors.statusGreen),
            ),
          ),
        ),
        Positioned(
          bottom: 100,
          left: 0,
          right: 0,
          child: Column(
            children: [
              if (_capturing)
                const Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: CircularProgressIndicator(color: AppColors.white),
                ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: AppColors.black.withOpacity(0.55),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: _color, width: 1.5),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(_icons[_status], color: _color, size: 18),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Text(
                        _messages[_status]!,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.rubik.copyWith(
                          color: AppColors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _OvalPainter extends CustomPainter {
  _OvalPainter({required this.oval, required this.color, this.scrim = false});
  final Rect oval;
  final Color color;
  final bool scrim;

  @override
  void paint(Canvas canvas, Size size) {
    if (scrim) {
      canvas.drawPath(
        Path()
          ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
          ..addOval(oval)
          ..fillType = PathFillType.evenOdd,
        Paint()..color = Colors.black.withOpacity(0.55),
      );
    }
    canvas.drawOval(
      oval,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3,
    );
  }

  @override
  bool shouldRepaint(covariant _OvalPainter old) =>
      old.color != color || old.oval != oval;
}

class _OvalClipper extends CustomClipper<Path> {
  _OvalClipper(this.oval);
  final Rect oval;
  @override
  Path getClip(Size _) => Path()..addOval(oval);
  @override
  bool shouldReclip(covariant _OvalClipper old) => old.oval != oval;
}

class _RingPainter extends CustomPainter {
  _RingPainter(this.progress, this.color);
  final double progress;
  final Color color;
  @override
  void paint(Canvas canvas, Size size) => canvas.drawArc(
    (Offset.zero & size).deflate(2),
    -3.14159 / 2,
    2 * 3.14159 * progress,
    false,
    Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round,
  );
  @override
  bool shouldRepaint(covariant _RingPainter old) =>
      old.progress != progress || old.color != color;
}
