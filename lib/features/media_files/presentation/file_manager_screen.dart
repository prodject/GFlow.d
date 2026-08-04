import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/glass_card.dart';

/// Embedded Storage & USB File Manager Screen.
class FileManagerScreen extends StatelessWidget {
  const FileManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgDark,
      appBar: const CustomAppBar(title: 'File Manager'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Storage Stats Card
              GlassCard(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    _StoragePill(label: 'Internal Storage', size: '48 GB / 64 GB free'),
                    _StoragePill(label: 'USB Drive', size: '120 GB / 256 GB free'),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // File Directory List
              Expanded(
                child: ListView(
                  children: const [
                    _FileTile(icon: Icons.folder, title: 'DVR Recordings', subtitle: '48 Files (Videos)'),
                    _FileTile(icon: Icons.folder, title: 'Logs & Diagnostics', subtitle: '12 Files (gflow-diagnostics.txt)'),
                    _FileTile(icon: Icons.folder, title: 'Music & Audio', subtitle: '124 Tracks'),
                    _FileTile(icon: Icons.insert_drive_file, title: 'gflow.log', subtitle: '1.2 MB'),
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

class _StoragePill extends StatelessWidget {
  final String label;
  final String size;
  const _StoragePill({required this.label, required this.size});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 14)),
        const SizedBox(height: 4),
        Text(size, style: const TextStyle(color: AppTheme.accentCyan, fontWeight: FontWeight.bold, fontSize: 16)),
      ],
    );
  }
}

class _FileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _FileTile({required this.icon, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(icon, color: AppTheme.accentCyan, size: 32),
        title: Text(title, style: const TextStyle(color: AppTheme.textPrimary, fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: const TextStyle(color: AppTheme.textSecondary)),
        trailing: const Icon(Icons.arrow_forward_ios, color: AppTheme.textMuted, size: 16),
      ),
    );
  }
}
