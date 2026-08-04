import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

/// Floating Voice Listener Overlay UI.
class VoiceListeningOverlay extends StatelessWidget {
  const VoiceListeningOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppTheme.bgDark.withOpacity(0.9),
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: AppTheme.accentCyan, width: 2),
          boxShadow: [
            BoxShadow(
              color: AppTheme.accentCyan.withOpacity(0.3),
              blurRadius: 25,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.mic, color: AppTheme.accentCyan, size: 60),
            SizedBox(height: 16),
            Text(
              'Слушаю команду...',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.textPrimary),
            ),
            SizedBox(height: 8),
            Text(
              'Например: "Включи климат 22 градуса"',
              style: TextStyle(fontSize: 14, color: AppTheme.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
