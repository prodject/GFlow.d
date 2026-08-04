import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/glass_card.dart';

/// Monji DVR Dashcam Manager Screen.
class DvrScreen extends StatefulWidget {
  const DvrScreen({super.key});

  @override
  State<DvrScreen> createState() => _DvrScreenState();
}

class _DvrScreenState extends State<DvrScreen> {
  bool _isRecording = true;
  String _resolution = '1080p';
  int _segmentLength = 3; // minutes

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgDark,
      appBar: const CustomAppBar(title: 'Monji DVR Manager'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Recording Status Card
              GlassCard(
                borderColor: _isRecording ? AppTheme.accentRed : AppTheme.glassBorder,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.fiber_manual_record, color: _isRecording ? AppTheme.accentRed : AppTheme.textMuted, size: 28),
                        const SizedBox(width: 12),
                        Text(
                          _isRecording ? 'DVR RECORDING ACTIVE' : 'DVR PAUSED',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: _isRecording ? AppTheme.accentRed : AppTheme.textMuted,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: _isRecording ? AppTheme.cardDark : AppTheme.accentRed),
                      onPressed: () => setState(() => _isRecording = !_isRecording),
                      child: Text(_isRecording ? 'PAUSE' : 'START'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Settings Card
              GlassCard(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Quality Resolution', style: TextStyle(fontSize: 16, color: AppTheme.textPrimary)),
                        DropdownButton<String>(
                          value: _resolution,
                          dropdownColor: AppTheme.surfaceDark,
                          items: ['720p', '1080p']
                              .map((res) => DropdownMenuItem(value: res, child: Text(res, style: const TextStyle(color: AppTheme.textPrimary))))
                              .toList(),
                          onChanged: (val) => setState(() => _resolution = val!),
                        ),
                      ],
                    ),
                    const Divider(color: AppTheme.glassBorder),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Segment Duration', style: TextStyle(fontSize: 16, color: AppTheme.textPrimary)),
                        Text('$_segmentLength min', style: const TextStyle(color: AppTheme.accentCyan, fontWeight: FontWeight.bold)),
                      ],
                    ),
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
