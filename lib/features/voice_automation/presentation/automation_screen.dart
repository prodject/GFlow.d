import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/glass_card.dart';

/// Smart Automation Scenarios & Macro Chains Screen.
class AutomationScreen extends StatelessWidget {
  const AutomationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgDark,
      appBar: const CustomAppBar(title: 'Smart Automation Engine v2'),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildScenarioCard('Winter Comfort Preset', 'Trigger: Boot & Temp < 5°C', 'Seat Heat Level 3, Defrost ON, Temp 24°C', true),
            _buildScenarioCard('Parking Guard Mode', 'Trigger: Vehicle Locked', 'DVR Motion Detect ON, Mirrors Folded', true),
            _buildScenarioCard('Rain Auto Protect', 'Trigger: Wipers Active', 'Close Windows, Close Sunroof', true),
            _buildScenarioCard('Low-Speed Camera Auto-Pop', 'Trigger: Speed < 15 km/h', 'Show AVM 360 View Overlay', true),
          ],
        ),
      ),
    );
  }

  Widget _buildScenarioCard(String title, String trigger, String actions, bool enabled) {
    return GlassCard(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.accentCyan)),
              Switch(value: enabled, activeColor: AppTheme.accentCyan, onChanged: (val) {}),
            ],
          ),
          const SizedBox(height: 6),
          Text(trigger, style: const TextStyle(color: AppTheme.accentOrange, fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text(actions, style: const TextStyle(color: AppTheme.textSecondary)),
        ],
      ),
    );
  }
}
