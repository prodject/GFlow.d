import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';

/// GFlow Desktop Launcher Hub (Custom Launcher & App Grid with OneOS Dock).
class DesktopScreen extends StatelessWidget {
  const DesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgDark,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar Weather & Clock Widget
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '14:35',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  GlassCard(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: const [
                        Icon(Icons.wb_sunny, color: AppTheme.accentOrange, size: 24),
                        SizedBox(width: 8),
                        Text(
                          'Moscow +18°C',
                          style: TextStyle(fontSize: 16, color: AppTheme.textPrimary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // App Grid (4x3 Grid of Automotive Apps)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GridView.count(
                  crossAxisCount: 4,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    _buildAppTile(context, Icons.navigation, 'Navigation', AppTheme.accentCyan),
                    _buildAppTile(context, Icons.music_note, 'Yandex Music', AppTheme.accentOrange),
                    _buildAppTile(context, Icons.videocam, 'GFlow DVR', AppTheme.accentRed),
                    _buildAppTile(context, Icons.directions_car, 'Vehicle Control', AppTheme.accentBlue),
                    _buildAppTile(context, Icons.shield, 'ADAS Safety', AppTheme.accentGreen),
                    _buildAppTile(context, Icons.mic, 'Vosk Voice', AppTheme.accentCyan),
                    _buildAppTile(context, Icons.settings, 'Settings', AppTheme.textSecondary),
                    _buildAppTile(context, Icons.folder, 'File Manager', AppTheme.accentOrange),
                  ],
                ),
              ),
            ),

            // OneOS Bottom DockBar
            Container(
              height: 70,
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.surfaceDark.withOpacity(0.9),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppTheme.glassBorder),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    iconSize: 32,
                    icon: const Icon(Icons.home, color: AppTheme.accentCyan),
                    onPressed: () {},
                  ),
                  IconButton(
                    iconSize: 32,
                    icon: const Icon(Icons.apps, color: AppTheme.textPrimary),
                    onPressed: () {},
                  ),
                  IconButton(
                    iconSize: 32,
                    icon: const Icon(Icons.ac_unit, color: AppTheme.accentBlue),
                    onPressed: () {},
                  ),
                  IconButton(
                    iconSize: 32,
                    icon: const Icon(Icons.settings, color: AppTheme.textSecondary),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppTile(BuildContext context, IconData icon, String title, Color color) {
    return GlassCard(
      onTap: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 40),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
