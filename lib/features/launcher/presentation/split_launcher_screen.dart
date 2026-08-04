import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/glass_card.dart';

/// Split Launcher Screen (Multi-window side-by-side app launcher).
class SplitLauncherScreen extends StatelessWidget {
  const SplitLauncherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgDark,
      appBar: const CustomAppBar(title: 'Multi-Window Split Screen'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Left App Slot (Primary App: e.g. Yandex Navigation)
              Expanded(
                child: GlassCard(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.navigation_outlined, color: AppTheme.accentCyan, size: 60),
                      SizedBox(height: 16),
                      Text(
                        'Primary App: Navigation',
                        style: TextStyle(fontSize: 18, color: AppTheme.textPrimary, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Right App Slot (Secondary App: e.g. Music Player)
              Expanded(
                child: GlassCard(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.music_note_outlined, color: AppTheme.accentOrange, size: 60),
                      SizedBox(height: 16),
                      Text(
                        'Secondary App: Music Player',
                        style: TextStyle(fontSize: 18, color: AppTheme.textPrimary, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
