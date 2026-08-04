import 'package:flutter/material.dart';
import 'core/channels/car_channel_service.dart';
import 'core/theme/app_theme.dart';
import 'core/widgets/car_vector_view.dart';
import 'core/widgets/climate_bottom_drawer.dart';
import 'core/widgets/hvac_bottom_bar.dart';
import 'features/launcher/presentation/desktop_screen.dart';
import 'features/media_files/presentation/file_manager_screen.dart';
import 'features/system_settings/presentation/settings_screen.dart';
import 'features/vehicle_adas/presentation/adas_screen.dart';
import 'features/vehicle_adas/presentation/dvr_screen.dart';
import 'features/vehicle_adas/presentation/vehicle_screen.dart';
import 'features/voice_automation/presentation/voice_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const GFlowAutomotiveApp());
}

class GFlowAutomotiveApp extends StatelessWidget {
  const GFlowAutomotiveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GFlow Monji',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final CarChannelService _carChannelService = CarChannelService();

  bool _climatePower = true;
  double _driverTemp = 22.0;
  double _passengerTemp = 22.5;
  int _fanSpeed = 3;
  bool _doorLocked = true;
  int _outdoorTemp = 18;
  int _speed = 45;

  @override
  void initState() {
    super.initState();
    _initCarState();
    _listenTelemetry();
  }

  void _initCarState() async {
    final state = await _carChannelService.getInitialState();
    if (state != null) {
      setState(() {
        _climatePower = (state['climatePower'] as bool?) ?? true;
        _driverTemp = (state['driverTemp'] as num?)?.toDouble() ?? 22.0;
        _passengerTemp = (state['passengerTemp'] as num?)?.toDouble() ?? 22.5;
        _fanSpeed = (state['fanSpeed'] as num?)?.toInt() ?? 3;
        _doorLocked = (state['doorLocked'] as bool?) ?? true;
        _outdoorTemp = (state['outdoorTemp'] as num?)?.toInt() ?? 18;
        _speed = (state['vehicleSpeed'] as num?)?.toInt() ?? 45;
      });
    }
  }

  void _listenTelemetry() {
    _carChannelService.telemetryStream.listen((data) {
      if (mounted) {
        setState(() {
          if (data.containsKey('climatePower')) {
            _climatePower = data['climatePower'] as bool;
          }
          if (data.containsKey('driverTemp')) {
            _driverTemp = (data['driverTemp'] as num).toDouble();
          }
          if (data.containsKey('passengerTemp')) {
            _passengerTemp = (data['passengerTemp'] as num).toDouble();
          }
          if (data.containsKey('fanSpeed')) {
            _fanSpeed = (data['fanSpeed'] as num).toInt();
          }
          if (data.containsKey('doorLocked')) {
            _doorLocked = data['doorLocked'] as bool;
          }
          if (data.containsKey('outdoorTemp')) {
            _outdoorTemp = (data['outdoorTemp'] as num).toInt();
          }
          if (data.containsKey('vehicleSpeed')) {
            _speed = (data['vehicleSpeed'] as num).toInt();
          }
        });
      }
    });
  }

  void _openClimateDrawer() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => ClimateBottomDrawer(
        driverTemp: _driverTemp,
        passengerTemp: _passengerTemp,
        fanSpeed: _fanSpeed,
        climatePower: _climatePower,
        onPowerToggled: (val) {
          setState(() => _climatePower = val);
          _carChannelService.sendClimateCommand('setPower', {'power': val});
        },
        onFanSpeedChanged: (speed) {
          setState(() => _fanSpeed = speed);
          _carChannelService.sendClimateCommand('setFanSpeed', {'speed': speed});
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgDark,
      body: SafeArea(
        child: Column(
          children: [
            // Top Split Hub View
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    // Left (2/3): Interactive 2.5D Car Vector View
                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const VehicleScreen()),
                        ),
                        child: CarVectorView(
                          doorLocked: _doorLocked,
                          headlightsOn: true,
                          outdoorTemp: _outdoorTemp,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Right (1/3): Modular Status Cards
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          _buildStatusCard(
                            title: 'ADAS Safety',
                            subtitle: 'AEB: Active | LKA: Normal',
                            icon: Icons.shield_outlined,
                            accentColor: AppTheme.accentGreen,
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const AdasScreen()),
                            ),
                          ),
                          const SizedBox(height: 12),
                          _buildStatusCard(
                            title: 'Monji DVR',
                            subtitle: 'REC 1080p | 48GB Free',
                            icon: Icons.videocam_outlined,
                            accentColor: AppTheme.accentOrange,
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const DvrScreen()),
                            ),
                          ),
                          const SizedBox(height: 12),
                          _buildStatusCard(
                            title: 'Launcher & Apps',
                            subtitle: 'Desktop Launcher Grid',
                            icon: Icons.apps,
                            accentColor: AppTheme.accentCyan,
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const DesktopScreen()),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Persistent HVAC Bottom Bar
            HvacBottomBar(
              driverTemp: _driverTemp,
              passengerTemp: _passengerTemp,
              fanSpeed: _fanSpeed,
              climatePower: _climatePower,
              onOpenClimateDrawer: _openClimateDrawer,
              onDriverTempChanged: (newTemp) {
                setState(() => _driverTemp = newTemp);
                _carChannelService.sendClimateCommand('setTemperature', {
                  'driverTemp': newTemp,
                  'passengerTemp': _passengerTemp,
                });
              },
              onPassengerTempChanged: (newTemp) {
                setState(() => _passengerTemp = newTemp);
                _carChannelService.sendClimateCommand('setTemperature', {
                  'driverTemp': _driverTemp,
                  'passengerTemp': newTemp,
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color accentColor,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.surfaceDark.withOpacity(0.6),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppTheme.glassBorder),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, color: accentColor, size: 28),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppTheme.textSecondary,
                      ),
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
