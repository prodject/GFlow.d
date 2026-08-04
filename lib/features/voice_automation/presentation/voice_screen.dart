import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/glass_card.dart';

/// Vosk Offline Voice Recognizer & Command History Screen.
class VoiceScreen extends StatelessWidget {
  const VoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgDark,
      appBar: const CustomAppBar(title: 'Vosk Voice Assistant'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GlassCard(
                child: Row(
                  children: [
                    const Icon(Icons.mic, color: AppTheme.accentCyan, size: 40),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Offline Vosk Engine: ACTIVE', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.accentCyan)),
                        SizedBox(height: 4),
                        Text('Model: vosk-model-ru (Russian)', style: TextStyle(color: AppTheme.textSecondary)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text('Voice Command Aliases', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
              const SizedBox(height: 10),
              Expanded(
                child: ListView(
                  children: const [
                    _AliasTile(phrase: '"Включи климат"', action: 'HVAC Power ON'),
                    _AliasTile(phrase: '"Согрей салон"', action: 'Temp 24.5°C + Seat Heating'),
                    _AliasTile(phrase: '"Закрой двери"', action: 'Central Door Lock'),
                    _AliasTile(phrase: '"Включи запись"', action: 'Monji DVR Capture'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AliasTile extends StatelessWidget {
  final String phrase;
  final String action;
  const _AliasTile({required this.phrase, required this.action});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(phrase, style: const TextStyle(color: AppTheme.accentCyan, fontSize: 16, fontWeight: FontWeight.bold)),
          Text(action, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 14)),
        ],
      ),
    );
  }
}
