import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/custom_app_bar.dart';

/// Media & Video Viewer for DVR recordings playback.
class MediaViewerScreen extends StatelessWidget {
  const MediaViewerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const CustomAppBar(title: 'Media Viewer - DVR Playback'),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.play_circle_fill, color: AppTheme.accentCyan, size: 80),
                    SizedBox(height: 16),
                    Text(
                      'dvr_rec_20260804_143000.mp4',
                      style: TextStyle(color: AppTheme.textPrimary, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            // Video Controls Bar
            Container(
              height: 70,
              color: AppTheme.surfaceDark,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Icon(Icons.replay_10, color: AppTheme.textPrimary, size: 32),
                  Icon(Icons.pause_circle_filled, color: AppTheme.accentCyan, size: 48),
                  Icon(Icons.forward_10, color: AppTheme.textPrimary, size: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
