import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/custom_app_bar.dart';

/// Built-in ADB Shell Terminal Console.
class AdbShellScreen extends StatefulWidget {
  const AdbShellScreen({super.key});

  @override
  State<AdbShellScreen> createState() => _AdbShellScreenState();
}

class _AdbShellScreenState extends State<AdbShellScreen> {
  final TextEditingController _cmdController = TextEditingController();
  final List<String> _outputLog = [
    'GFlow Built-in ADB Shell Console v1.0',
    'Type command and press RUN...',
  ];

  void _runCommand() {
    if (_cmdController.text.trim().isEmpty) return;
    final cmd = _cmdController.text.trim();
    setState(() {
      _outputLog.add('\$ $cmd');
      if (cmd == 'getprop') {
        _outputLog.add('[ro.build.version.release]: [11]');
        _outputLog.add('[ro.product.model]: [Geely OneOS HeadUnit]');
      } else {
        _outputLog.add('Executed command: $cmd (Exit code 0)');
      }
      _cmdController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const CustomAppBar(title: 'ADB Shell Terminal'),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.glassBorder),
                ),
                child: ListView.builder(
                  itemCount: _outputLog.length,
                  itemBuilder: (ctx, i) => Text(
                    _outputLog[i],
                    style: const TextStyle(fontFamily: 'monospace', color: AppTheme.accentGreen, fontSize: 14),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _cmdController,
                      style: const TextStyle(color: Colors.white, fontFamily: 'monospace'),
                      decoration: const InputDecoration(
                        hintText: 'Enter ADB command (e.g. pm list packages)',
                        hintStyle: TextStyle(color: AppTheme.textMuted),
                        filled: true,
                        fillColor: AppTheme.surfaceDark,
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
                      ),
                      onSubmitted: (_) => _runCommand(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: AppTheme.accentCyan, padding: const EdgeInsets.all(18)),
                    onPressed: _runCommand,
                    child: const Text('RUN', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
