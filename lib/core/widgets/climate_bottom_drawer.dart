import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Modal Glass Climate Control Bottom Drawer (60% Screen Height).
class ClimateBottomDrawer extends StatelessWidget {
  final double driverTemp;
  final double passengerTemp;
  final int fanSpeed;
  final bool climatePower;
  final Function(bool) onPowerToggled;
  final Function(int) onFanSpeedChanged;

  const ClimateBottomDrawer({
    super.key,
    required this.driverTemp,
    required this.passengerTemp,
    required this.fanSpeed,
    required this.climatePower,
    required this.onPowerToggled,
    required this.onFanSpeedChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.60,
      decoration: BoxDecoration(
        color: AppTheme.bgDark.withOpacity(0.95),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        border: Border.all(color: AppTheme.glassBorder, width: 1.5),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drawer Top Pill Drag Handle
          Center(
            child: Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: AppTheme.glassBorder,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Climate Control',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
              Switch(
                value: climatePower,
                activeColor: AppTheme.accentCyan,
                onChanged: onPowerToggled,
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Fan Speed Slider (1-9)
          Text(
            'Fan Speed: $fanSpeed / 9',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.textSecondary,
            ),
          ),
          Slider(
            value: fanSpeed.toDouble(),
            min: 1,
            max: 9,
            divisions: 8,
            activeColor: AppTheme.accentCyan,
            inactiveColor: AppTheme.cardDark,
            onChanged: (val) => onFanSpeedChanged(val.round()),
          ),
          const SizedBox(height: 20),

          // Quick Presets Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildPresetCard(context, Icons.ac_unit, 'Fast Cool'),
              _buildPresetCard(context, Icons.local_fire_department, 'Fast Heat'),
              _buildPresetCard(context, Icons.air, 'Defrost'),
              _buildPresetCard(context, Icons.eco, 'Eco Climate'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPresetCard(BuildContext context, IconData icon, String label) {
    return Container(
      width: 100,
      height: 90,
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.glassBorder),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppTheme.accentCyan, size: 28),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
