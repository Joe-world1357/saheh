# 🏥 Saheeh - Your Health Journey Companion

<div align="center">

![Saheeh Logo](assets/Logo.png)

**A comprehensive health and wellness management platform built with Flutter**

[![Flutter](https://img.shields.io/badge/Flutter-3.9.2-02569B?logo=flutter)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.9.2-0175C2?logo=dart)](https://dart.dev/)
[![License](https://img.shields.io/badge/License-Private-red)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web%20%7C%20Linux%20%7C%20Windows%20%7C%20macOS-lightgrey)](https://flutter.dev/)

</div>

---

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Screenshots](#screenshots)
- [Installation](#installation)
- [Project Structure](#project-structure)
- [Key Features](#key-features)
- [Development](#development)
- [Documentation](#documentation)
- [Contributing](#contributing)
- [License](#license)

---

## 🎯 Overview

**Saheeh** (صحيح) is a comprehensive health and wellness management application designed to help users track, manage, and improve their overall health. The app provides integrated tools for medication management, nutrition tracking, fitness monitoring, medical appointments, pharmacy services, and health data tracking.

### Key Highlights

- ✅ **Cross-platform** - Works on Android, iOS, Web, Linux, Windows, and macOS
- ✅ **Offline-first** - Local SQLite database for offline functionality
- ✅ **Bilingual** - Full support for English and Arabic (RTL)
- ✅ **Modern UI** - Material Design 3 with light/dark mode support
- ✅ **Gamification** - XP system and achievements to motivate users
- ✅ **Wearable Integration** - Connect with Google Fit and Bluetooth devices
- ✅ **AI-Powered** - Intelligent health chatbot with context-aware responses

---

## ✨ Features

### 🏠 Home Dashboard
- Personalized daily summary
- Quick access to all features
- XP and level tracking
- AI health insights
- Today's progress overview

### 💊 Medicine Management
- Medication reminders with notifications
- Schedule management (time, days of week)
- Intake tracking and history
- Prescription upload and management
- Pharmacy integration for ordering

### 🥗 Nutrition Tracking
- Meal logging with photo capture
- Barcode scanner for food items
- Macro and calorie tracking (protein, carbs, fats)
- Nutrition goals and progress
- Custom meal creation
- Nutrient analysis

### 💪 Fitness & Workouts
- Comprehensive workout library
- Muscle group-specific routines
- Workout tracking and history
- Activity tracker
- XP rewards for workouts
- Fitness onboarding for first-time users

### 🏥 Health Services
- Doctor appointments booking
- Home health caregiver services
- Lab tests scheduling
- Medical records management
- Health reports and progress tracking

### 📊 Health Tracking
- Sleep tracking and analysis
- Water intake monitoring
- Health goals setting
- Progress reports
- Activity data sync from wearables

### 🛒 Pharmacy Services
- Medication search and browsing
- Product details and reviews
- Shopping cart and checkout
- Order tracking
- Address management
- Prescription upload

### 🤖 AI Health Chatbot
- Context-aware health advice
- Nutrition and fitness queries
- Bilingual support (English/Arabic)
- Knowledge base integration
- Actionable health suggestions

### ⚙️ Settings & Customization
- Theme selection (light/dark/system)
- Language selection (English/Arabic)
- Notification preferences
- Privacy controls
- Device connectivity (Google Fit, wearables)
- Data sync settings

---

## 🛠 Tech Stack

### Core Framework
- **Flutter** 3.9.2 - Cross-platform UI framework
- **Dart** 3.9.2 - Programming language

### State Management
- **Riverpod** 3.0.3 - State management solution

### Database & Storage
- **SQLite (sqflite)** 2.4.2 - Local relational database
- **Hive** 2.2.3 - Local key-value storage for authentication
- **Shared Preferences** 2.2.2 - Simple key-value storage

### Health & Fitness
- **health** 13.2.1 - Google Fit / Health Connect integration
- **flutter_blue_plus** 1.32.0 - Bluetooth device connectivity

### UI & Design
- **Material Design 3** - Modern UI components
- **Custom Theme System** - Centralized colors and typography
- **RTL Support** - Right-to-left layout for Arabic

### Notifications
- **flutter_local_notifications** 17.0.0 - Local push notifications
- **timezone** 0.9.4 - Timezone-aware scheduling

### Media & Scanning
- **camera** 0.11.0+1 - Camera access
- **image_picker** 1.1.2 - Image selection
- **mobile_scanner** 5.2.3 - Barcode/QR code scanning

### Utilities
- **http** 1.2.0 - HTTP requests
- **crypto** 3.0.5 - Password hashing
- **intl** 0.20.2 - Internationalization
- **url_launcher** 6.3.2 - URL opening
- **permission_handler** 11.3.1 - Runtime permissions

---

## 📸 Screenshots

> _Screenshots coming soon!_

---

## 🚀 Installation

### Prerequisites

- Flutter SDK 3.9.2 or higher
- Dart SDK 3.9.2 or higher
- Android Studio / Xcode (for mobile development)
- VS Code or Android Studio (recommended IDEs)

### Setup Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/Joe-world1357/saheh.git
   cd saheh
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   # For Android
   flutter run -d android

   # For iOS
   flutter run -d ios

   # For Linux (release mode recommended)
   flutter run --release -d linux

   # For Web
   flutter run -d chrome
   ```

4. **Build the app**
   ```bash
   # Android APK
   flutter build apk --release

   # iOS IPA
   flutter build ios --release

   # Linux
   flutter build linux --release
   ```

### Platform-Specific Setup

#### Android
- Minimum SDK: 26 (Android 8.0)
- Target SDK: Latest
- Required permissions are automatically configured

#### iOS
- Minimum iOS version: 12.0
- Configure signing in Xcode

#### Linux
- Use release mode for better performance:
  ```bash
  flutter run --release -d linux
  ```

---

## 📁 Project Structure

```
lib/
├── core/                    # Core functionality
│   ├── chatbot/            # AI chatbot service
│   ├── constants/          # App-wide constants
│   ├── localization/      # i18n support
│   ├── notifications/     # Notification service
│   ├── permissions/       # Permission handling
│   ├── services/          # Core services (Google Fit, XP, etc.)
│   ├── storage/           # Local storage (Hive)
│   └── theme/             # Theme system (colors, text styles)
│
├── database/               # Database layer
│   └── database_helper.dart # SQLite operations
│
├── features/              # Feature modules
│   ├── auth/             # Authentication & onboarding
│   ├── communication/    # Chat & video consultation
│   ├── fitness/          # Workout & activity tracking
│   ├── health/           # Health metrics & reminders
│   ├── home/             # Dashboard & navigation
│   ├── nutrition/        # Meal tracking & analysis
│   ├── pharmacy/         # Medication ordering
│   ├── profile/          # User profile management
│   ├── services/         # Medical services booking
│   └── settings/         # App configuration
│
├── models/               # Data models
│   ├── user_model.dart
│   ├── meal_model.dart
│   ├── workout_model.dart
│   └── ...
│
├── providers/            # State management (Riverpod)
│   ├── auth_provider.dart
│   ├── theme_provider.dart
│   └── ...
│
├── repositories/        # Data repositories
│   └── ...
│
├── shared/              # Shared components
│   └── widgets/        # Reusable UI widgets
│
└── main.dart            # Application entry point
```

---

## 🔑 Key Features

### Authentication System
- Secure local authentication with password hashing
- User registration and login
- Password reset flow
- Guest mode access
- Session management

### XP & Gamification System
- Earn XP for various activities:
  - Logging meals
  - Completing workouts
  - Taking medications
  - Syncing activity data
  - Achieving health goals
- Level progression
- Achievement badges
- XP redemption system

### Google Fit Integration
- Connect to Google Fit / Health Connect
- Sync steps, heart rate, calories, sleep, workouts
- Automatic XP calculation from synced data
- Real-time data updates
- Manual sync option

### Wearable Device Support
- Bluetooth device scanning
- Support for popular wearables (Fitbit, Samsung, Garmin, etc.)
- Real-time activity data sync
- Connection status monitoring

### AI Health Chatbot
- Natural language understanding
- Context-aware responses
- Nutrition and fitness knowledge base
- Bilingual support (English/Arabic)
- Actionable health suggestions
- FAQ responses for app features

### Database Schema
The app uses SQLite with the following main tables:
- `users` - User profiles and XP data
- `medicine_reminders` - Medication schedules
- `meals` - Nutrition tracking
- `workouts` - Fitness activities
- `appointments` - Medical appointments
- `sleep_tracking` - Sleep data
- `water_intake` - Hydration tracking
- `health_goals` - User health objectives
- `achievements` - User achievements
- `xp_redemptions` - XP redemption history

---

## 💻 Development

### Running in Debug Mode
```bash
flutter run
```

### Running in Release Mode (Faster)
```bash
flutter run --release
```

### Code Analysis
```bash
flutter analyze
```

### Running Tests
```bash
flutter test
```

### Hot Reload
- Press `r` in the terminal for hot reload
- Press `R` for hot restart
- Press `q` to quit

### Building for Production

#### Android
```bash
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk
```

#### iOS
```bash
flutter build ios --release
```

#### Linux
```bash
flutter build linux --release
```

---

## 📚 Documentation

The project includes comprehensive documentation:

- **[System Overview & SRS](System_Overview_Functional_Plan_SRS.md)** - Complete system requirements and architecture
- **[Database Setup](DATABASE_SETUP.md)** - Database schema and setup guide
- **[GUI Front End SRS](GUI_Front_End_SRS.md)** - UI/UX specifications
- **[Wearable & Google Fit Integration](WEARABLE_GOOGLE_FIT_INTEGRATION.md)** - Health data sync guide
- **[Chatbot Enhancement Report](CHATBOT_ENHANCEMENT_REPORT.md)** - AI chatbot documentation
- **[Testing Chapter](TESTING_CHAPTER.md)** - Testing guidelines and test cases
- **[Validation System](VALIDATION_SYSTEM.md)** - Input validation documentation
- **[Crash Fix Summary](CRASH_FIX_SUMMARY.md)** - Known issues and fixes

### Quick Links
- [Google Fit Connection Guide](GOOGLE_FIT_CONNECTION_GUIDE.md)
- [Refactoring Summary](REFACTORING_SUMMARY.md)
- [SQLite Integration](SQLITE_INTEGRATION_COMPLETE.md)

---

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Code Style
- Follow Flutter/Dart style guidelines
- Use meaningful variable and function names
- Add comments for complex logic
- Maintain consistency with existing code structure

### Commit Messages
- Use clear, descriptive commit messages
- Reference issue numbers if applicable
- Follow conventional commit format when possible

---

## 📝 License

This project is private and proprietary. All rights reserved.

---

## 👥 Authors

- **Development Team** - [Joe-world1357](https://github.com/Joe-world1357)

---

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- All open-source package contributors
- Material Design team for design guidelines

---

## 📞 Support

For support, email [eng.yousif1357@gmail.com](mailto:eng.yousif1357@gmail.com) or open an issue in the repository.

---

## 🔗 Links

- **Repository:** [https://github.com/Joe-world1357/saheh](https://github.com/Joe-world1357/saheh)
- **Flutter Documentation:** [https://docs.flutter.dev/](https://docs.flutter.dev/)
- **Dart Documentation:** [https://dart.dev/](https://dart.dev/)

---

<div align="center">

**Made with ❤️ using Flutter**

⭐ Star this repo if you find it helpful!

</div>
