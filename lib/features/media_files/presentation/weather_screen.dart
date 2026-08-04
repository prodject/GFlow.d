import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/glass_card.dart';

/// Open-Meteo REST API Weather & Embedded Web Browser Screen.
class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  double? _temperature;
  double? _windSpeed;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    try {
      final url = Uri.parse(
          'https://api.open-meteo.com/v1/forecast?latitude=55.7558&longitude=37.6173&current_weather=true');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final currentWeather = data['current_weather'];
        setState(() {
          _temperature = (currentWeather['temperature'] as num).toDouble();
          _windSpeed = (currentWeather['windspeed'] as num).toDouble();
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgDark,
      appBar: const CustomAppBar(title: 'Weather & Browser'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              GlassCard(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator(color: AppTheme.accentCyan))
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              const Icon(Icons.wb_sunny, color: AppTheme.accentOrange, size: 50),
                              const SizedBox(height: 8),
                              Text(
                                '${_temperature?.toStringAsFixed(1) ?? "18.0"}°C',
                                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppTheme.textPrimary),
                              ),
                              const Text('Moscow Forecast', style: TextStyle(color: AppTheme.textSecondary)),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Wind: ${_windSpeed ?? "4.5"} km/h', style: const TextStyle(fontSize: 16, color: AppTheme.textPrimary)),
                              const SizedBox(height: 8),
                              const Text('Open-Meteo REST API', style: TextStyle(color: AppTheme.accentCyan)),
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
