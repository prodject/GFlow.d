import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// 2.5D Interactive Vector Canvas of vehicle with neon status glows.
class CarVectorView extends StatelessWidget {
  final bool doorLocked;
  final bool headlightsOn;
  final int outdoorTemp;

  const CarVectorView({
    super.key,
    required this.doorLocked,
    required this.headlightsOn,
    required this.outdoorTemp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark.withOpacity(0.6),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.glassBorder),
      ),
      padding: const EdgeInsets.all(20),
      child: CustomPaint(
        painter: _CarVectorPainter(
          doorLocked: doorLocked,
          headlightsOn: headlightsOn,
        ),
        child: Stack(
          children: [
            // Outdoor Temp Pill
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.cardDark.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppTheme.glassBorder),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.thermostat, color: AppTheme.accentCyan, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      '$outdoorTemp°C Outer',
                      style: const TextStyle(
                        color: AppTheme.textPrimary,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Lock Status Badge
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: (doorLocked ? AppTheme.accentCyan : AppTheme.accentOrange)
                      .withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: doorLocked ? AppTheme.accentCyan : AppTheme.accentOrange,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      doorLocked ? Icons.lock : Icons.lock_open,
                      color: doorLocked ? AppTheme.accentCyan : AppTheme.accentOrange,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      doorLocked ? 'LOCKED' : 'UNLOCKED',
                      style: TextStyle(
                        color: doorLocked ? AppTheme.accentCyan : AppTheme.accentOrange,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CarVectorPainter extends CustomPainter {
  final bool doorLocked;
  final bool headlightsOn;

  _CarVectorPainter({required this.doorLocked, required this.headlightsOn});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final width = size.width * 0.45;
    final height = size.height * 0.7;

    final carRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: center, width: width, height: height),
      const Radius.circular(30),
    );

    // Car Body Fill & Outline
    final bodyPaint = Paint()
      ..color = AppTheme.cardDark
      ..style = PaintingStyle.fill;
    canvas.drawRRect(carRect, bodyPaint);

    final borderPaint = Paint()
      ..color = AppTheme.accentCyan.withOpacity(0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;
    canvas.drawRRect(carRect, borderPaint);

    // Windshield & Sunroof
    final glassPaint = Paint()
      ..color = AppTheme.accentCyan.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    final windshieldRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(center.dx, center.dy - height * 0.2),
        width: width * 0.7,
        height: height * 0.22,
      ),
      const Radius.circular(10),
    );
    canvas.drawRRect(windshieldRect, glassPaint);

    // Headlights Beam Glow
    if (headlightsOn) {
      final glowPaint = Paint()
        ..color = AppTheme.accentCyan.withOpacity(0.3)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15);

      final leftBeam = Path()
        ..moveTo(center.dx - width * 0.35, center.dy - height * 0.5)
        ..lineTo(center.dx - width * 0.5, center.dy - height * 0.75)
        ..lineTo(center.dx - width * 0.2, center.dy - height * 0.75)
        ..close();
      canvas.drawPath(leftBeam, glowPaint);

      final rightBeam = Path()
        ..moveTo(center.dx + width * 0.35, center.dy - height * 0.5)
        ..lineTo(center.dx + width * 0.2, center.dy - height * 0.75)
        ..lineTo(center.dx + width * 0.5, center.dy - height * 0.75)
        ..close();
      canvas.drawPath(rightBeam, glowPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _CarVectorPainter oldDelegate) {
    return oldDelegate.doorLocked != doorLocked ||
        oldDelegate.headlightsOn != headlightsOn;
  }
}
