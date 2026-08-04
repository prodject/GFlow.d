import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/glass_card.dart';

/// Vehicle Body & Drive Modes Control Screen.
class VehicleScreen extends StatefulWidget {
  const VehicleScreen({super.key});

  @override
  State<VehicleScreen> createState() => _VehicleScreenState();
}

class _VehicleScreenState extends State<VehicleScreen> {
  bool _doorLock = true;
  double _sunroofPos = 0; // % open
  String _driveMode = 'Comfort';
  String _lightingMode = 'Auto';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgDark,
      appBar: const CustomAppBar(title: 'Vehicle & Body Controls'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Central Door Lock & Trunk
              Row(
                children: [
                  Expanded(
                    child: GlassCard(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Central Door Lock', style: TextStyle(fontSize: 16, color: AppTheme.textPrimary)),
                          Switch(
                            value: _doorLock,
                            activeColor: AppTheme.accentCyan,
                            onChanged: (val) => setState(() => _doorLock = val),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: GlassCard(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Power Trunk', style: TextStyle(fontSize: 16, color: AppTheme.textPrimary)),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.cardDark),
                            onPressed: () {},
                            child: const Text('OPEN', style: TextStyle(color: AppTheme.accentOrange)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Sunroof Position Slider
              GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Panoramic Sunroof: ${_sunroofPos.round()}% Open', style: const TextStyle(fontSize: 16, color: AppTheme.textPrimary)),
                    Slider(
                      value: _sunroofPos,
                      min: 0,
                      max: 100,
                      activeColor: AppTheme.accentCyan,
                      onChanged: (val) => setState(() => _sunroofPos = val),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Drive Modes Selector
              const Text('Drive Mode Selector', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: ['Eco', 'Comfort', 'Dynamic', 'Snow', 'Offroad']
                    .map((mode) => _buildDriveModePill(mode))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDriveModePill(String mode) {
    final isSelected = _driveMode == mode;
    return GestureDetector(
      onTap: () => setState(() => _driveMode = mode),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.accentCyan.withOpacity(0.2) : AppTheme.surfaceDark,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isSelected ? AppTheme.accentCyan : AppTheme.glassBorder),
        ),
        child: Text(
          mode,
          style: TextStyle(
            color: isSelected ? AppTheme.accentCyan : AppTheme.textSecondary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
