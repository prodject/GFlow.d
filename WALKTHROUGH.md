# WALKTHROUGH — Обзор реализации GFlow / GControl

## Описание проекта
Приложение **GFlow / GControl** разработано для головных устройств на базе **Android Automotive OS (Geely OneOS, ECARX, Zeekr)**.
Архитектура сочетает единый Android Host приложение (`com.prodject.gflow`, `minSdk 30`, `compileSdk 35`, `targetSdk 35`) и высокопроизводительный **Flutter UI** в стиле **Tesla / OneOS Dark Glassmorphic Theme**.

---

## Иерархия файлов проекта

```
GFlow/
├── pubspec.yaml
├── analysis_options.yaml
├── README.md
├── WALKTHROUGH.md
├── CHECKLIST.md
├── android/
│   ├── build.gradle
│   ├── settings.gradle
│   └── app/
│       ├── build.gradle
│       └── src/main/
│           ├── AndroidManifest.xml
│           └── java/com/prodject/gflow/
│               ├── MainActivity.java
│               ├── bus/
│               │   └── CarCommandBus.java
│               ├── channel/
│               │   └── PlatformChannelManager.java
│               ├── diagnostics/
│               │   └── DiagnosticsRunner.java
│               ├── engine/
│               │   ├── AutomationEngine.java
│               │   ├── SmartClimateController.java
│               │   └── UserProfileEngine.java
│               ├── hal/
│               │   ├── CarHalAdapter.java
│               │   ├── EcarxVehicleAdapter.java
│               │   └── MockCarHalAdapter.java
│               ├── receivers/
│               │   ├── BootReceiver.java
│               │   ├── DiagnosticsAutomationReceiver.java
│               │   ├── SplitCommandReceiver.java
│               │   ├── SteeringWheelReceiver.java
│               │   └── VoiceTriggerReceiver.java
│               ├── services/
│               │   ├── AppWatchdogAccessibilityService.java
│               │   ├── CameraForegroundService.java
│               │   ├── DvrService.java
│               │   ├── GFlowMediaSessionListener.java
│               │   ├── LowSpeedCameraService.java
│               │   └── VoiceForegroundService.java
│               └── voice/
│                   └── VoiceFlowRouter.java
└── lib/
    ├── main.dart
    ├── core/
    │   ├── channels/
    │   │   └── car_channel_service.dart
    │   ├── theme/
    │   │   └── app_theme.dart
    │   └── widgets/
    │       ├── car_vector_view.dart
    │       ├── climate_bottom_drawer.dart
    │       ├── custom_app_bar.dart
    │       ├── glass_card.dart
    │       └── hvac_bottom_bar.dart
    └── features/
        ├── launcher/presentation/
        │   ├── desktop_screen.dart
        │   └── split_launcher_screen.dart
        ├── media_files/presentation/
        │   ├── file_manager_screen.dart
        │   ├── media_viewer_screen.dart
        │   ├── text_viewer_screen.dart
        │   └── weather_screen.dart
        ├── system_settings/presentation/
        │   ├── adb_shell_screen.dart
        │   ├── profile_screen.dart
        │   └── settings_screen.dart
        ├── vehicle_adas/presentation/
        │   ├── adas_screen.dart
        │   ├── camera_screen.dart
        │   ├── dvr_screen.dart
        │   └── vehicle_screen.dart
        └── voice_automation/presentation/
            ├── automation_screen.dart
            ├── steering_screen.dart
            ├── voice_listening_overlay.dart
            └── voice_screen.dart
```

---

## Описание основных подсистем

### 1. Vendor HAL & Platform Channels
- **`CarHalAdapter.java`**: Абстрактный низкоуровневый интерфейс HAL для кузова, климата и ADAS.
- **`MockCarHalAdapter.java`**: Симулятор шины CAN реального времени с выдачей потока данных каждые 1.5 сек.
- **`EcarxVehicleAdapter.java`**: Адаптер вендорных сервисов ECARX с динамической рефлексией и фоллбэком.
- **`CarCommandBus.java`**: Потокобезопасный центральный маршрутизатор команд.
- **`PlatformChannelManager.java`**: Двусторонний мост для `MethodChannel("com.prodject.gflow/command")` и `EventChannel("com.prodject.gflow/telemetry")`.

### 2. Фоновые службы и приёмники
- **`VoiceForegroundService.java` & `VoiceFlowRouter.java`**: Поддержка офлайн-распознавателя речи Vosk.
- **`DvrService.java`**: Фоновая запись видеорегистратора GFlow DVR.
- **`LowSpeedCameraService.java`**: Авто-вывод камер AVM 360 при скорости < 15 км/ч.
- **`AppWatchdogAccessibilityService.java`**: Масштабирование DPI (Autozoom).
- **`GFlowMediaSessionListener.java`**: Перехват метаданных активных плееров.

### 3. Автомобильный Flutter UI (Tesla OS Style)
- **`main.dart` (Tesla-Style Split Dashboard Hub)**: Левая область (2/3) с 2.5D векторным кузовом (`CarVectorView`) + правая область (1/3) с карточками статуса + закрепленная нижняя панель климата (`HvacBottomBar`).
- **`climate_bottom_drawer.dart`**: Выезжающая 60% стекло-шторка климат-контроля с регулятором вентилятора (1-9) и смарт-пресетами.
- **6 Функциональных Хабов**:
  - *Launcher Hub*: `desktop_screen.dart`, `split_launcher_screen.dart`.
  - *Vehicle & ADAS Hub*: `vehicle_screen.dart`, `adas_screen.dart`, `camera_screen.dart`, `dvr_screen.dart`.
  - *Media & Files Hub*: `file_manager_screen.dart`, `media_viewer_screen.dart`, `text_viewer_screen.dart`, `weather_screen.dart` (REST API Open-Meteo).
  - *Voice & Automation Hub*: `voice_screen.dart`, `automation_screen.dart`, `steering_screen.dart`, `voice_listening_overlay.dart`.
  - *System & Settings Hub*: `settings_screen.dart`, `profile_screen.dart`, `adb_shell_screen.dart`.
