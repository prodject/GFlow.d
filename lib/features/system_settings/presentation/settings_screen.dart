import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/glass_card.dart';

/// System Settings Screen (DPI Scale, Autozoom, GitHub Updates).
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double _dpiScale = 1.0;
  bool _autozoom = true;
  bool _autoStart = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgDark,
      appBar: const CustomAppBar(title: 'GFlow System Settings'),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            GlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Interface Scale (DPI): ${_dpiScale.toStringAsFixed(2)}x', style: const TextStyle(fontSize: 16, color: AppTheme.textPrimary)),
                  Slider(
                    value: _dpiScale,
                    min: 0.75,
                    max: 1.5,
                    divisions: 6,
                    activeColor: AppTheme.accentCyan,
                    onChanged: (val) => setState(() => _dpiScale = val),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            GlassCard(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('App Watchdog Autozoom (Per-app DPI)', style: TextStyle(fontSize: 16, color: AppTheme.textPrimary)),
                  Switch(value: _autozoom, activeColor: AppTheme.accentCyan, onChanged: (v) => setState(() => _autozoom = v)),
                ],
              ),
            ),
            const SizedBox(height: 12),
            GlassCard(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Autostart on Boot (BOOT_COMPLETED)', style: TextStyle(fontSize: 16, color: AppTheme.textPrimary)),
                  Switch(value: _autoStart, activeColor: AppTheme.accentCyan, onChanged: (v) => setState(() => _autoStart = v)),
                ],
              ),
            ),
            const SizedBox(height: 12),
            GlassCard(
              child: ListTile(
                leading: const Icon(Icons.system_update, color: AppTheme.accentCyan),
                title: const Text('Check GitHub Release Updates', style: TextStyle(color: AppTheme.textPrimary, fontWeight: FontWeight.bold)),
                subtitle: const Text('Current version: 1.0.0+1 (targetSdk 35)'),
                trailing: const Icon(Icons.chevron_right, color: AppTheme.textMuted),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
