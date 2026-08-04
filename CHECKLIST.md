# CHECKLIST — Чек-лист готовности функционала GFlow / GControl (Monji)

## 1. Конфигурация Проекта & Target SDK 35
- [x] Целевая платформа: Android Automotive OS (Geely OneOS, ECARX, Zeekr)
- [x] Пакет приложения: `com.prodject.gflow`
- [x] Настройка `minSdk 30`, `compileSdk 35`, `targetSdk 35` в `android/app/build.gradle`
- [x] Функция `android.hardware.type.automotive` и разрешения в `AndroidManifest.xml`

## 2. Native Layer & HAL Adapters
- [x] Абстрактный интерфейс `CarHalAdapter.java`
- [x] Адаптер эмулятора `MockCarHalAdapter.java` с таймером симуляции CAN-телеметрии (каждые 1.5 сек)
- [x] Адаптер вендора `EcarxVehicleAdapter.java` с рефлексией и безопасным фоллбэком
- [x] Центральная шина команд `CarCommandBus.java`
- [x] Связка Platform Channels `PlatformChannelManager.java` (`com.prodject.gflow/command`, `com.prodject.gflow/telemetry`)
- [x] Главный хост `MainActivity.java`

## 3. Фоновые Службы & Receiver Компоненты
- [x] `VoiceForegroundService.java` (Офлайн Vosk)
- [x] `VoiceFlowRouter.java` (Маршрутизатор голосовых команд)
- [x] `DvrService.java` (Запись видеорегистратора 1080p)
- [x] `CameraForegroundService.java` (Удержание видеозахвата)
- [x] `LowSpeedCameraService.java` (Авто-вызов AVM 360 при скорости < 15 км/ч)
- [x] `GFlowMediaSessionListener.java` (Перехват метаданных плееров)
- [x] `AppWatchdogAccessibilityService.java` (Autozoom DPI масштабирование)
- [x] `BootReceiver.java` (Автозапуск при загрузке ГУ)
- [x] `SteeringWheelReceiver.java` (Перехват кнопок мультируля Geely/ECARX)
- [x] `VoiceTriggerReceiver.java` (Интент-триггер голоса `app.monji.VOICE`)
- [x] `DiagnosticsAutomationReceiver.java` (Вещание диагноста)
- [x] `SplitCommandReceiver.java` (Управление Split Screen)

## 4. Ядро Автоматизации & Профилей
- [x] `SmartClimateController.java` (Умная адаптация температуры)
- [x] `AutomationEngine.java` (Движок сценариев v2)
- [x] `UserProfileEngine.java` (Профили сидений/зеркал/климата)
- [x] `DiagnosticsRunner.java` (Сканер AdaptAPI и выгрузка `gflow-diagnostics.txt`)

## 5. Flutter UI Layer (Tesla OS Dark Glassmorphism)
- [x] Дизайн-система `AppTheme` (`#0E131F`, `#1A2235`, `#00E5FF`, touch target ≥ 64dp)
- [x] Драйвер каналов `CarChannelService`
- [x] Векторный 2.5D кузов `CarVectorView` (CustomPainter)
- [x] Несъемный Bottom Dock `HvacBottomBar`
- [x] Модальная 60% шторка `ClimateBottomDrawer`
- [x] Главный панельный экран `main.dart` (Tesla Split Dashboard Hub)
- [x] *Launcher Hub*: `desktop_screen.dart`, `split_launcher_screen.dart`
- [x] *Vehicle & ADAS Hub*: `vehicle_screen.dart`, `adas_screen.dart`, `camera_screen.dart`, `dvr_screen.dart`
- [x] *Media & Files Hub*: `file_manager_screen.dart`, `media_viewer_screen.dart`, `text_viewer_screen.dart`, `weather_screen.dart` (Open-Meteo REST API)
- [x] *Voice & Automation Hub*: `voice_screen.dart`, `automation_screen.dart`, `steering_screen.dart`, `voice_listening_overlay.dart`
- [x] *System & Settings Hub*: `settings_screen.dart`, `profile_screen.dart`, `adb_shell_screen.dart`
