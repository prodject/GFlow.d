import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/glass_card.dart';

/// Driver Profiles Management Screen.
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _activeProfile = 'Driver 1 (Alexey)';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgDark,
      appBar: const CustomAppBar(title: 'Driver Profiles'),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildProfileTile('Driver 1 (Alexey)', 'Seats, Mirrors, 22.0°C Climate, Comfort Mode', true),
            _buildProfileTile('Driver 2 (Guest)', 'Default Factory Settings', false),
            _buildProfileTile('Passenger Preset', 'Seat Heating Lvl 2, Temp 23.5°C', false),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileTile(String name, String details, bool isActive) {
    return GlassCard(
      margin: const EdgeInsets.only(bottom: 12),
      borderColor: isActive ? AppTheme.accentCyan : AppTheme.glassBorder,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
                  if (isActive) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppTheme.accentCyan.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text('ACTIVE', style: TextStyle(color: AppTheme.accentCyan, fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 4),
              Text(details, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 13)),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: isActive ? AppTheme.accentCyan : AppTheme.surfaceDark),
            onPressed: () => setState(() => _activeProfile = name),
            child: Text(isActive ? 'SAVED' : 'APPLY', style: TextStyle(color: isActive ? Colors.black : AppTheme.textPrimary)),
          ),
        ],
      ),
    );
  }
}
