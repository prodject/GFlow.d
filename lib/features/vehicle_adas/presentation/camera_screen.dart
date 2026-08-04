import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/glass_card.dart';

/// Camera Overview & AVM 360 Viewing Screen.
class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  String _activeSource = 'AVM 360';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgDark,
      appBar: const CustomAppBar(title: 'Camera Streams & AVM 360'),
      body: SafeArea(
        child: Column(
          children: [
            // Video Stream Viewport
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: AppTheme.glassBorder),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.videocam, color: AppTheme.accentCyan, size: 60),
                      const SizedBox(height: 12),
                      Text(
                        'Streaming: $_activeSource',
                        style: const TextStyle(fontSize: 18, color: AppTheme.textPrimary),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Camera Source Selector
            Container(
              height: 70,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: ['AVM 360', 'Front ADAS', 'Rear View', 'Side Mirrors']
                    .map((src) => _buildSourceBtn(src))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSourceBtn(String source) {
    final isSel = _activeSource == source;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSel ? AppTheme.accentCyan : AppTheme.surfaceDark,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      onPressed: () => setState(() => _activeSource = source),
      child: Text(source, style: TextStyle(color: isSel ? Colors.black : AppTheme.textPrimary)),
    );
  }
}
