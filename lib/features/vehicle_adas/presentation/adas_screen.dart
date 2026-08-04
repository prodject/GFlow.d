import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/glass_card.dart';

/// ADAS Active Safety Settings Screen.
class AdasScreen extends StatefulWidget {
  const AdasScreen({super.key});

  @override
  State<AdasScreen> createState() => _AdasScreenState();
}

class _AdasScreenState extends State<AdasScreen> {
  bool _aeb = true;
  bool _fcw = true;
  bool _lka = true;
  bool _bsd = true;
  bool _tsr = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgDark,
      appBar: const CustomAppBar(title: 'ADAS & Active Safety'),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildAdasToggle('AEB - Autonomous Emergency Braking', _aeb, (v) => setState(() => _aeb = v)),
            _buildAdasToggle('FCW - Forward Collision Warning', _fcw, (v) => setState(() => _fcw = v)),
            _buildAdasToggle('LKA/LDW - Lane Keep Assist', _lka, (v) => setState(() => _lka = v)),
            _buildAdasToggle('BSD - Blind Spot Detection', _bsd, (v) => setState(() => _bsd = v)),
            _buildAdasToggle('TSR - Traffic Sign Recognition', _tsr, (v) => setState(() => _tsr = v)),
          ],
        ),
      ),
    );
  }

  Widget _buildAdasToggle(String title, bool value, Function(bool) onChanged) {
    return GlassCard(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 16, color: AppTheme.textPrimary, fontWeight: FontWeight.w500)),
          Switch(
            value: value,
            activeColor: AppTheme.accentGreen,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
