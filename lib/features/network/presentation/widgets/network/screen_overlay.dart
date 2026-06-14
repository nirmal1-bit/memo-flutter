import 'package:flutter/material.dart';

class ScannerOverlay extends StatelessWidget {
  const ScannerOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.maxWidth * 0.7;

        return Stack(
          children: [
            Container(color: Colors.black.withOpacity(0.6)),

            Center(
              child: SizedBox(
                width: size,
                height: size,
                child: CustomPaint(painter: _ScannerBorderPainter()),
              ),
            ),

            /// 📝 Instruction text
            const Positioned(
              bottom: 100,
              left: 0,
              right: 0,
              child: Text(
                "Align QR code inside the box",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ScannerBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.greenAccent
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    const corner = 25.0;

    final path = Path();

    path.moveTo(0, corner);
    path.lineTo(0, 0);
    path.lineTo(corner, 0);

    path.moveTo(size.width - corner, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, corner);

    path.moveTo(size.width, size.height - corner);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width - corner, size.height);

    path.moveTo(corner, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, size.height - corner);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
