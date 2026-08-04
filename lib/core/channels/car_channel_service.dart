import 'dart:async';
import 'package:flutter/services.dart';

/// CarChannelService: Dart wrapper for Native MethodChannel & EventChannel.
class CarChannelService {
  static const MethodChannel _methodChannel =
      MethodChannel('com.prodject.gflow/command');
  static const EventChannel _eventChannel =
      EventChannel('com.prodject.gflow/telemetry');

  Stream<Map<String, dynamic>>? _telemetryStream;

  /// Stream of real-time vehicle CAN bus telemetry updates
  Stream<Map<String, dynamic>> get telemetryStream {
    _telemetryStream ??= _eventChannel
        .receiveBroadcastStream()
        .map((dynamic event) => Map<String, dynamic>.from(event as Map));
    return _telemetryStream!;
  }

  /// Request current vehicle & climate state from Native bus
  Future<Map<String, dynamic>?> getInitialState() async {
    try {
      final res = await _methodChannel.invokeMethod('getInitialState');
      if (res != null) {
        return Map<String, dynamic>.from(res as Map);
      }
    } on PlatformException catch (e) {
      // Log platform errors silently
    }
    return null;
  }

  /// Execute Climate action (setPower, setTemperature, setFanSpeed, etc.)
  Future<bool> sendClimateCommand(
      String action, Map<String, dynamic> args) async {
    try {
      final bool? success = await _methodChannel.invokeMethod<bool>(
        'executeClimateCommand',
        {'action': action, 'args': args},
      );
      return success ?? false;
    } on PlatformException catch (e) {
      return false;
    }
  }

  /// Execute Vehicle action (setDoorLock, setWindow, setTrunk, etc.)
  Future<bool> sendVehicleCommand(
      String action, Map<String, dynamic> args) async {
    try {
      final bool? success = await _methodChannel.invokeMethod<bool>(
        'executeVehicleCommand',
        {'action': action, 'args': args},
      );
      return success ?? false;
    } on PlatformException catch (e) {
      return false;
    }
  }
}
