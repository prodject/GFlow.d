import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Persistent Bottom HVAC Control Bar.
class HvacBottomBar extends StatelessWidget {
  final double driverTemp;
  final double passengerTemp;
  final int fanSpeed;
  final bool climatePower;
  final VoidCallback onOpenClimateDrawer;
  final Function(double) onDriverTempChanged;
  final Function(double) onPassengerTempChanged;

  const HvacBottomBar({
    super.key,
    required this.driverTemp,
    required this.passengerTemp,
    required this.fanSpeed,
    required this.climatePower,
    required this.onOpenClimateDrawer,
    required this.onDriverTempChanged,
    required this.onPassengerTempChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark.withOpacity(0.95),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppTheme.glassBorder, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Driver Temp Selector
          Row(
            children: [
              IconButton(
                iconSize: 28,
                icon: const Icon(Icons.remove_circle_outline, color: AppTheme.accentCyan),
                onPressed: () => onDriverTempChanged(driverTemp - 0.5),
              ),
              GestureDetector(
                onTap: onOpenClimateDrawer,
                child: Text(
                  '${driverTemp.toStringAsFixed(1)}°C',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ),
              IconButton(
                iconSize: 28,
                icon: const Icon(Icons.add_circle_outline, color: AppTheme.accentCyan),
                onPressed: () => onDriverTempChanged(driverTemp + 0.5),
              ),
            ],
          ),

          // Fan Speed / Power Pill (Triggers Drawer)
          InkWell(
            onTap: onOpenClimateDrawer,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                color: climatePower
                    ? AppTheme.accentCyan.withOpacity(0.15)
                    : AppTheme.cardDark,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: climatePower ? AppTheme.accentCyan : AppTheme.glassBorder,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.toys,
                    color: climatePower ? AppTheme.accentCyan : AppTheme.textMuted,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    climatePower ? 'Fan Lvl $fanSpeed' : 'CLIMATE OFF',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: climatePower ? AppTheme.accentCyan : AppTheme.textMuted,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(Icons.keyboard_arrow_up, color: AppTheme.accentCyan),
                ],
              ),
            ),
          ),

          // Passenger Temp Selector
          Row(
            children: [
              IconButton(
                iconSize: 28,
                icon: const Icon(Icons.remove_circle_outline, color: AppTheme.accentCyan),
                onPressed: () => onPassengerTempChanged(passengerTemp - 0.5),
              ),
              GestureDetector(
                onTap: onOpenClimateDrawer,
                child: Text(
                  '${passengerTemp.toStringAsFixed(1)}°C',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ),
              IconButton(
                iconSize: 28,
                icon: const Icon(Icons.add_circle_outline, color: AppTheme.accentCyan),
                onPressed: () => onPassengerTempChanged(passengerTemp + 0.5),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
