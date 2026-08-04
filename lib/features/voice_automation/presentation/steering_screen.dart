import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/glass_card.dart';

/// Steering Wheel Key Remapping & Gestures Screen.
class SteeringScreen extends StatelessWidget {
  const SteeringScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgDark,
      appBar: const CustomAppBar(title: 'Steering Wheel Button Remapping'),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: const [
            _KeyBindingCard(buttonName: 'Geely Custom Key ⭐', gesture: 'Single Press', mappedAction: 'Launch Vosk Voice Assistant'),
            _KeyBindingCard(buttonName: 'Geely Custom Key ⭐', gesture: 'Double Press', mappedAction: 'Toggle AVM 360 Camera'),
            _KeyBindingCard(buttonName: 'Geely Custom Key ⭐', gesture: 'Long Hold', mappedAction: 'Mute Audio & Open Climate Drawer'),
            _KeyBindingCard(buttonName: 'Voice Key 🎙️', gesture: 'Single Press', mappedAction: 'Activate Voice Listening'),
          ],
        ),
      ),
    );
  }
}

class _KeyBindingCard extends StatelessWidget {
  final String buttonName;
  final String gesture;
  final String mappedAction;

  const _KeyBindingCard({required this.buttonName, required this.gesture, required this.mappedAction});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(buttonName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
              const SizedBox(height: 4),
              Text(gesture, style: const TextStyle(color: AppTheme.accentCyan)),
            ],
          ),
          Text(mappedAction, style: const TextStyle(color: AppTheme.textSecondary, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
