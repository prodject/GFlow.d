# GFlow / GControl — Automotive Head Unit System

![Android Automotive OS](https://img.shields.io/badge/Platform-Android%20Automotive%20OS%2011%2B-blue)
![Target SDK](https://img.shields.io/badge/TargetSDK-35-brightgreen)
![Flutter](https://img.shields.io/badge/UI-Flutter%203.x-02569B)
![Build Status](https://github.com/prodject/GFlow.d/actions/workflows/build-release.yml/badge.svg)

**GFlow / GControl** is a comprehensive, production-ready automotive application engineered specifically for **Android Automotive OS Car Head Units (Geely OneOS, ECARX, Zeekr)**.

It seamlessly bridges low-level vehicle Hardware Abstraction Layers (HAL / CAN bus telemetry) with a modern, high-contrast **Tesla OS / OneOS Dark Glassmorphic Flutter UI**.

---

## 🚘 Technical Specifications

- **Application Package**: `com.prodject.gflow`
- **Target Platform**: Android 11+ (`minSdk 30`, `compileSdk 35`, `targetSdk 35`)
- **Native Core Layer (Java / Kotlin)**: Low-level automotive foreground services, ECARX AdaptAPI adapters, CAN bus signal event channels, JNI Vosk offline speech engine.
- **UI & UX Layer (Dart / Flutter)**: Clean Architecture + BLoC state management, Tesla-Style Split Dashboard, 2.5D interactive vector vehicle canvas, glove-friendly controls (touch targets ≥ 64dp).
- **Inter-Layer Communication**: Bi-directional Platform Channels (`MethodChannel` for commands, `EventChannel` for continuous CAN telemetry streaming).
- **CI/CD Pipeline**: GitHub Actions automated build pipeline with static signing key for update compatibility.

---

## 🎨 UI Architecture — Tesla OS Glassmorphism

The user interface avoids fragmented screens by consolidating 6 core functional hubs around a **Tesla-Style Split Dashboard**:

```
┌────────────────────────────────────────────────────────────────────────────────────────┐
│                                GFLOW AUTOMOTIVE OS                                     │
├──────────────────────────────────────────────────────┬─────────────────────────────────┤
│                                                      │  [ 🌡️ Climate Status Card ]     │
│             2.5D VEHICLE CANVAS                      │  • Driver: 22.0° | Pass: 22.5°   │
│         (CustomPainter Vector Model)                 │  • Fan: Level 3  | Auto Mode    │
│                                                      ├─────────────────────────────────┤
│    ┌───────────────────────────────────────────┐     │  [ 🛡️ ADAS & Safety Card ]     │
│    │  [🚗] Interactive Door & Lamp Glow        │     │  • AEB: ON   | LKA: Active      │
│    │  [🛞] Live Tire Pressure Indicators       │     │  • BSD: Active | TSR: 60 km/h    │
│    └───────────────────────────────────────────┘     ├─────────────────────────────────┤
│                                                      │  [ 📹 DVR & Cameras Card ]      │
│            MAP & NAVIGATION CARD                     │  • REC: 1080p | Front + Rear    │
│            (Live position & route)                   │  • Storage: 48 GB Free          │
│                                                      ├─────────────────────────────────┤
│                                                      │  [ 🌤️ Open-Meteo Weather ]     │
│                                                      │  • Moscow: +18°C Sunny          │
├──────────────────────────────────────────────────────┴─────────────────────────────────┤
│ 🔈 [Temp -] 22.0°C | 💨 Fan [1..9] | [❄️ AC] | [🔥 Seats] | 22.5°C [Temp +] | 🎙️ [Vosk]│
│                        (Persistent Bottom HVAC Dock Bar)                               │
└────────────────────────────────────────────────────────────────────────────────────────┘
```

### 🌟 Key Functional Features
1. **Interactive 2.5D Vector Vehicle View**: Real-time canvas rendering door lock statuses, headlights, trunk state, and ambient conditions without heavy 3D overhead.
2. **Persistent HVAC Dock & 60% Sliding Climate Drawer**: Instant climate controls accessible at all times while driving.
3. **Offline Voice Assistant (Vosk)**: Local speech recognition engine processing vehicle commands (climate, locks, seat heaters).
4. **Automated Parking Camera Popup**: `LowSpeedCameraService` automatically invokes AVM 360 camera preview when vehicle speed drops below 15 km/h.
5. **GFlow DVR Engine**: 1080p background dashcam video recording service.
6. **Open-Meteo REST Weather Service**: Live weather integration.
7. **Built-in ADB Shell Console & AdaptAPI Diagnostics**: Self-diagnostics scanner generating `gflow-diagnostics.txt`.

---

## 🛠️ Project Structure

```
GFlow/
├── .github/workflows/
│   └── build-release.yml        # GitHub Actions build & publish workflow
├── android/                     # Native Android Automotive OS Host
│   ├── app/src/main/AndroidManifest.xml
│   └── app/src/main/java/com/prodject/gflow/
│       ├── bus/CarCommandBus.java
│       ├── channel/PlatformChannelManager.java
│       ├── hal/                 # ECARX & Mock HAL Adapters
│       ├── receivers/           # Boot, Steering Key, & Voice Receivers
│       └── services/            # Foreground & Accessibility Services
└── lib/                         # Flutter Layer
    ├── main.dart
    ├── core/theme/app_theme.dart # Dark Glassmorphic Design System
    └── features/                # 6 Functional Feature Modules
```

---

## 📦 Building & Publishing

### Local Build
Ensure you have the Flutter SDK installed and target JDK 17 configured:

```bash
# Get dependencies
flutter pub get

# Build Release APK for Android Automotive OS
flutter build apk --release
```

### CI/CD Release
Every commit pushed to `main` or tag matching `v*` triggers `.github/workflows/build-release.yml`.
The workflow automatically builds the release APK signed with a static debug key and publishes the asset to **GitHub Releases**.

---

## 📄 License
This project is licensed under private repository terms for GFlow Automotive OS.
