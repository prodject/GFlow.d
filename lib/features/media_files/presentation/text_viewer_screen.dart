import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/custom_app_bar.dart';

/// Text and Log file viewer (.log, .txt, .json, .md).
class TextViewerScreen extends StatelessWidget {
  final String fileName;
  final String content;

  const TextViewerScreen({
    super.key,
    this.fileName = 'gflow-diagnostics.txt',
    this.content = '=== GFLOW AUTOMOTIVE DIAGNOSTICS REPORT ===\n'
        'Timestamp: 1722771600000\n'
        'OS Version: 11.0 (API 30)\n'
        'Device Hardware: ECARX E02 / Geely OneOS\n'
        '[AVAILABLE] ecarx.os.car.ECarManager\n'
        '[AVAILABLE] ecarx.os.car.CarSignalManager\n'
        '[AVAILABLE] ecarx.os.car.AudioExtService\n',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgDark,
      appBar: CustomAppBar(title: fileName),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.glassBorder),
            ),
            child: Text(
              content,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 14,
                color: AppTheme.accentGreen,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
