# Software Requirement Specification (SRS)
## System Overview & Functional Plan

**Document Version:** 1.0  
**Date:** 2025-01-27  
**Project:** Sehati Health App  
**Platform:** Flutter (Cross-platform: Android, iOS, Web, Linux, macOS, Windows)

---

## 1. Executive Summary

The Sehati Health App is a comprehensive health and wellness management platform built with Flutter. It provides users with integrated tools for medication management, nutrition tracking, fitness monitoring, medical appointments, pharmacy services, and health data tracking. The application follows a feature-based architecture with centralized state management and a modular design for scalability and maintainability.

---

## 2. System Overview

### 2.1 High-Level Architecture

The application follows a **feature-based modular architecture** with clear separation of concerns:

```
lib/
├── core/                    # Core functionality and constants
│   ├── constants/          # App-wide constants
│   └── theme/              # Theme system (colors, text styles, themes)
│
├── database/               # Local database layer
│   └── database_helper.dart # SQLite database operations
│
├── features/               # Feature modules (business logic)
│   ├── auth/              # Authentication & onboarding
│   ├── communication/     # Chat & video consultation
│   ├── fitness/           # Workout & activity tracking
│   ├── health/            # Health metrics & reminders
│   ├── home/              # Dashboard & navigation
│   ├── nutrition/         # Meal tracking & analysis
│   ├── pharmacy/          # Medication ordering
│   ├── profile/           # User profile management
│   ├── services/          # Medical services booking
│   └── settings/          # App configuration
│
├── models/                # Data models
│   ├── user_model.dart
│   ├── order_model.dart
│   ├── medicine_reminder_model.dart
│   ├── meal_model.dart
│   ├── workout_model.dart
│   ├── appointment_model.dart
│   └── health_tracking_model.dart
│
├── providers/              # State management (Riverpod)
│   ├── theme_provider.dart
│   ├── user_provider.dart
│   ├── cart_provider.dart
│   ├── orders_provider.dart
│   ├── reminders_provider.dart
│   ├── nutrition_provider.dart
│   ├── workouts_provider.dart
│   ├── health_tracking_provider.dart
│   ├── appointments_provider.dart
│   └── settings_provider.dart
│
├── shared/                # Shared components
│   └── widgets/           # Reusable UI components
│
└── main.dart              # Application entry point
```

### 2.2 Core Modules

#### 2.2.1 Core Module (`lib/core/`)
- **Constants:** App-wide configuration values
- **Theme System:**
  - `app_colors.dart`: Centralized color definitions
  - `app_text_styles.dart`: Typography system
  - `app_theme.dart`: Theme utilities and gradients

#### 2.2.2 Database Module (`lib/database/`)
- **DatabaseHelper:** SQLite database management
- **Tables:**
  - `users`: User profile data
  - `orders`: Pharmacy orders
  - `medicine_reminders`: Medication schedules
  - `meals`: Nutrition tracking
  - `workouts`: Fitness activities
  - `appointments`: Medical appointments
  - `sleep_tracking`: Sleep data
  - `water_intake`: Hydration tracking
  - `health_goals`: User health objectives

#### 2.2.3 Feature Modules (`lib/features/`)

Each feature module contains:
- `view/`: UI screens and widgets
- Business logic (may be separated into `controller/` or `service/`)

**Feature Breakdown:**

| Feature | Purpose | Key Screens |
|---------|---------|-------------|
| **Auth** | User authentication & onboarding | Splash, Login, Register, OTP, Password Reset |
| **Home** | Main dashboard & navigation | Home Screen, Guest Navbar, Notifications |
| **Pharmacy** | Medication ordering & management | Pharmacy, Cart, Checkout, Order Tracking |
| **Fitness** | Workout tracking & gamification | Dashboard, Workout Library, Activity Tracker, XP System |
| **Health** | Health metrics & reminders | Reminders, Sleep Tracker, Water Intake, Health Goals |
| **Nutrition** | Meal tracking & analysis | Nutrition Screen, Add Meal, Nutrient Analysis |
| **Services** | Medical service booking | Clinic, Home Health, Lab Tests |
| **Communication** | Healthcare provider interaction | Chat, Video Consultation, Reviews |
| **Profile** | User profile management | Profile, Edit Info, Achievements |
| **Settings** | App configuration | Settings, Privacy, Language, Preferences |

### 2.3 Dependencies & Tech Stack

#### 2.3.1 Core Framework
- **Flutter SDK:** ^3.9.2
- **Dart:** Latest stable version
- **Material Design 3:** Enabled (`useMaterial3: true`)

#### 2.3.2 State Management
- **flutter_riverpod:** ^3.0.3
  - Used for global state management
  - Theme, user, cart, orders, and feature-specific state

#### 2.3.3 Data Persistence
- **sqflite:** ^2.4.2
  - Local SQLite database for offline data storage
  - User data, orders, reminders, health tracking
- **shared_preferences:** ^2.2.2
  - Key-value storage for app settings
  - Theme preferences, user preferences
- **path:** ^1.9.1
  - Path manipulation for database files

#### 2.3.4 Utilities
- **intl:** ^0.20.2
  - Internationalization and date/time formatting
- **flutter_local_notifications:** ^17.0.0
  - Local push notifications for reminders

#### 2.3.5 Development Tools
- **flutter_native_splash:** ^2.4.0
  - Native splash screen generation
- **flutter_lints:** ^5.0.0
  - Code quality and linting rules

### 2.4 Theme & Style System Overview

#### 2.4.1 Architecture
- **Centralized Definition:** All colors and text styles in `lib/core/theme/`
- **Consistent Usage:** Theme constants referenced throughout app
- **Material 3:** Modern Material Design implementation

#### 2.4.2 Color System
- Primary brand color: Teal/Cyan (`#20C6B7`)
- Semantic colors: Success, Warning, Error, Info
- Nutrition-specific colors: Protein, Carbs, Fats, Calories
- Gray scale for text hierarchy

#### 2.4.3 Typography System
- Hierarchical text styles (Heading 1-4, Body, Button, Caption)
- Consistent font sizes and weights
- Responsive line heights

#### 2.4.4 Theme Modes
- **Light Mode:** Default, fully implemented
- **Dark Mode:** Provider exists, theme data partially implemented
- **System Mode:** Follows device brightness settings

---

## 3. Functional Requirements

### 3.1 Core Functions

#### 3.1.1 Splash & Onboarding
**Status:** ✅ Implemented

- **Splash Screen:**
  - Animated logo fade-in (2 seconds)
  - Auto-navigation to Welcome Screen (3 seconds)
  - Branding display

- **Welcome Screen:**
  - App introduction
  - Login/Register options
  - Guest access option
  - Google sign-in (UI only, not functional)

**User Flow:**
```
Splash → Welcome → [Login | Register | Guest]
```

#### 3.1.2 Navigation System
**Status:** ✅ Implemented

- **Bottom Navigation Bar:**
  - 5 main sections (Home, Pharmacy, Fitness, Services, Profile)
  - Persistent across screens
  - Visual feedback for active tab

- **Stack Navigation:**
  - Standard Flutter navigation for detail screens
  - Back button support
  - Screen transitions

**Limitations:**
- No deep linking
- No navigation guards
- No route configuration system

#### 3.1.3 Home Page
**Status:** ✅ Implemented

**Features:**
- Personalized greeting with user name
- XP/Level system display
- Quick action buttons (Medicines, Nutrition, Workout, Book)
- Today's Summary:
  - Daily overview (calories, steps, sleep)
  - Medicine reminders
  - Nutrition progress
  - Today's workout
  - AI health insights

**Data Display:**
- Static data (hardcoded values)
- No real-time data integration
- No backend API connection

#### 3.1.4 Settings
**Status:** ✅ Partially Implemented

**Implemented Sections:**
- Account Settings (Edit Info, Change Password, Login Methods)
- App Preferences (Language, Dark Mode toggle, Notifications toggle)
- Health & Fitness (Connect Devices, Sync Data, Workout/Nutrition Settings)
- Security & Privacy (2FA toggle, Connected Devices, Policies)
- Support (Help Center, Contact, Feedback, About)

**Functionality:**
- UI navigation to sub-screens
- Toggle switches (local state only)
- Settings persistence via SharedPreferences (partial)

**Limitations:**
- Dark mode toggle exists but doesn't fully switch themes
- Some settings not persisted
- No actual device connection functionality

### 3.2 Planned Dark Mode & Light Mode Functionality

#### 3.2.1 Current Status
- ✅ Theme provider implemented (`ThemeNotifier`)
- ✅ Theme toggle button widget created
- ✅ Theme state persistence (SharedPreferences)
- ⚠️ Dark theme data not configured in `main.dart`
- ⚠️ Most screens use hardcoded light colors

#### 3.2.2 Planned Implementation

**Phase 1: Theme Data Configuration**
- Add `darkTheme` to `MaterialApp` in `main.dart`
- Define dark color scheme
- Configure dark mode text styles

**Phase 2: Theme-Aware Components**
- Replace hardcoded colors with theme-aware colors
- Update all screens to use `Theme.of(context)`
- Ensure contrast ratios meet accessibility standards

**Phase 3: Smooth Transitions**
- Implement theme transition animations
- Test theme switching performance
- Ensure no UI glitches during theme changes

**Phase 4: Testing**
- Test all screens in both themes
- Verify readability and contrast
- Test on different devices

### 3.3 Expected User Interactions & Behaviors

#### 3.3.1 Authentication Flow
1. User opens app → Splash screen
2. Welcome screen appears
3. User selects:
   - **Login:** Enters credentials → Main app
   - **Register:** Creates account → Main app
   - **Guest:** Direct access to main app (limited features)

#### 3.3.2 Main App Navigation
1. User lands on Home screen
2. Bottom navigation allows switching between:
   - Home: Dashboard overview
   - Pharmacy: Browse and order medications
   - Fitness: Track workouts and activities
   - Services: Book medical appointments
   - Profile: Manage account and settings

#### 3.3.3 Feature Interactions

**Medicine Reminders:**
- View pending reminders
- Add new medication
- Set schedule (time, days of week)
- Mark as taken

**Nutrition Tracking:**
- Log meals
- View daily macro breakdown
- Set nutrition goals
- View progress charts

**Fitness:**
- Browse workout library
- Start workout session
- Track activities
- Earn XP and level up

**Pharmacy:**
- Search medications
- View product details
- Add to cart
- Checkout and place order
- Track order status

**Services:**
- Browse available doctors/caregivers
- View provider details
- Book appointments
- Manage bookings

#### 3.3.4 Settings Interactions
- Toggle dark mode
- Change language
- Enable/disable notifications
- Configure privacy settings
- Connect external devices
- Sync activity data

### 3.4 Future Improvements & Modules (Optional)

#### 3.4.1 Backend Integration
- **Priority:** High
- **Description:** Connect to REST API for:
  - User authentication
  - Real-time data sync
  - Cloud storage
  - Push notifications

#### 3.4.2 Enhanced Notifications
- **Priority:** Medium
- **Description:**
  - Medicine reminder notifications
  - Appointment reminders
  - Health goal achievements
  - Customizable notification preferences

#### 3.4.3 Social Features
- **Priority:** Low
- **Description:**
  - Share achievements
  - Connect with friends
  - Group challenges
  - Community forums

#### 3.4.4 Advanced Analytics
- **Priority:** Medium
- **Description:**
  - Health trend analysis
  - Predictive insights
  - Personalized recommendations
  - Export health reports

#### 3.4.5 Wearable Integration
- **Priority:** Medium
- **Description:**
  - Connect fitness trackers
  - Sync health data
  - Real-time activity monitoring

#### 3.4.6 Telemedicine
- **Priority:** High
- **Description:**
  - Video consultation implementation
  - Prescription management
  - Medical record sharing

#### 3.4.7 AI Features
- **Priority:** Medium
- **Description:**
  - AI health insights (currently static)
  - Personalized meal recommendations
  - Workout plan generation
  - Health risk assessment

---

## 4. Non-Functional Requirements

### 4.1 UI/UX Quality

#### 4.1.1 Design Consistency
- **Status:** ✅ Good
- **Implementation:**
  - Centralized theme system
  - Consistent color palette
  - Standardized typography
  - Reusable widget components

#### 4.1.2 User Experience
- **Status:** ⚠️ Needs Improvement
- **Current:**
  - Intuitive navigation
  - Clear visual hierarchy
  - Responsive touch targets
- **Needs:**
  - Loading states
  - Error handling UI
  - Empty states
  - Success feedback

#### 4.1.3 Accessibility
- **Status:** ⚠️ Basic
- **Current:**
  - Material Design accessibility features
- **Needs:**
  - Screen reader labels
  - High contrast mode
  - Keyboard navigation
  - Font scaling support

### 4.2 Performance

#### 4.2.1 App Launch Time
- **Target:** < 2 seconds
- **Current:** ✅ Meets target (splash screen handles loading)

#### 4.2.2 Screen Transition Speed
- **Target:** < 300ms
- **Current:** ✅ Meets target (standard Flutter transitions)

#### 4.2.3 Database Operations
- **Target:** < 100ms for simple queries
- **Current:** ✅ Expected to meet (SQLite is fast)
- **Note:** No performance testing conducted

#### 4.2.4 Memory Usage
- **Target:** Efficient memory management
- **Current:** ⚠️ Not measured
- **Recommendation:** Profile app for memory leaks

#### 4.2.5 Battery Efficiency
- **Target:** Minimal battery drain
- **Current:** ⚠️ Not measured
- **Recommendation:** Optimize background operations

### 4.3 Maintainability & Scalability

#### 4.3.1 Code Organization
- **Status:** ✅ Excellent
- **Strengths:**
  - Feature-based architecture
  - Clear separation of concerns
  - Modular structure
  - Reusable components

#### 4.3.2 Code Quality
- **Status:** ✅ Good
- **Implementation:**
  - Flutter lints enabled
  - Consistent naming conventions
  - Documentation in code
- **Needs:**
  - More comprehensive comments
  - API documentation
  - Architecture documentation

#### 4.3.3 Scalability
- **Status:** ✅ Good Foundation
- **Strengths:**
  - Modular architecture supports feature addition
  - State management scales well
  - Database structure supports growth
- **Considerations:**
  - Backend API integration needed for scale
  - Caching strategy for performance
  - Offline-first architecture

#### 4.3.4 Testing
- **Status:** ⚠️ Minimal
- **Current:**
  - Basic widget test file exists
- **Needs:**
  - Unit tests for business logic
  - Widget tests for UI components
  - Integration tests for user flows
  - Performance tests

#### 4.3.5 Documentation
- **Status:** ⚠️ Basic
- **Current:**
  - Code comments
  - This SRS document
- **Needs:**
  - API documentation
  - Developer guide
  - User manual
  - Architecture decision records

---

## 5. Functional Plan Roadmap

### 5.1 Implementation Status

#### 5.1.1 Completed Features ✅

| Feature | Status | Notes |
|---------|--------|-------|
| **UI Foundation** | ✅ Complete | Theme system, navigation, basic screens |
| **Splash & Onboarding** | ✅ Complete | Splash animation, welcome screen |
| **Home Dashboard** | ✅ Complete | UI implemented, static data |
| **Navigation System** | ✅ Complete | Bottom nav, stack navigation |
| **Pharmacy UI** | ✅ Complete | Browse, cart, checkout screens |
| **Fitness UI** | ✅ Complete | Dashboard, library, detail screens |
| **Health Tracking UI** | ✅ Complete | Reminders, sleep, water, goals screens |
| **Nutrition UI** | ✅ Complete | Tracking, analysis screens |
| **Services UI** | ✅ Complete | Clinic, home health, lab tests |
| **Profile & Settings UI** | ✅ Complete | Profile, settings screens |
| **Database Layer** | ✅ Complete | SQLite schema, CRUD operations |
| **State Management** | ✅ Complete | Riverpod providers for all features |
| **Theme System** | ⚠️ Partial | Light mode complete, dark mode partial |

#### 5.1.2 Partially Implemented Features ⚠️

| Feature | Status | What's Missing |
|---------|--------|----------------|
| **Dark Mode** | ⚠️ Partial | Theme data not configured, hardcoded colors |
| **Authentication** | ⚠️ UI Only | No backend integration, no real auth |
| **Settings Persistence** | ⚠️ Partial | Some settings not saved |
| **Notifications** | ⚠️ Partial | Library added, not implemented |
| **Data Integration** | ⚠️ None | All data is static/hardcoded |

#### 5.1.3 Planned Features 📋

| Feature | Priority | Estimated Effort |
|---------|----------|------------------|
| **Backend API Integration** | High | Large |
| **Dark Mode Completion** | High | Medium |
| **Real Authentication** | High | Medium |
| **Push Notifications** | High | Medium |
| **Data Sync** | High | Large |
| **Loading States** | Medium | Small |
| **Error Handling** | Medium | Medium |
| **Empty States** | Medium | Small |
| **Accessibility Improvements** | Medium | Medium |
| **Responsive Design** | Medium | Large |
| **Video Consultation** | Medium | Large |
| **Wearable Integration** | Low | Large |
| **Social Features** | Low | Large |
| **AI Features** | Low | Large |

### 5.2 Priority Roadmap

#### Phase 1: Core Functionality (High Priority)
**Timeline:** Immediate

1. **Complete Dark Mode** (2-3 weeks)
   - Configure dark theme in `main.dart`
   - Replace hardcoded colors with theme-aware colors
   - Test all screens in both themes

2. **Real Authentication** (3-4 weeks)
   - Backend API integration
   - JWT token management
   - Secure storage
   - Session management

3. **Data Integration** (4-6 weeks)
   - REST API client
   - Data models mapping
   - Error handling
   - Loading states

4. **Push Notifications** (2-3 weeks)
   - Configure FCM/APNS
   - Medicine reminders
   - Appointment notifications
   - Notification preferences

#### Phase 2: User Experience (Medium Priority)
**Timeline:** 2-3 months

1. **Loading & Error States** (1-2 weeks)
   - Loading indicators
   - Error messages
   - Retry mechanisms
   - Skeleton screens

2. **Empty States** (1 week)
   - No data illustrations
   - Helpful messages
   - Call-to-action buttons

3. **Accessibility** (2-3 weeks)
   - Screen reader support
   - High contrast mode
   - Keyboard navigation
   - Font scaling

4. **Responsive Design** (3-4 weeks)
   - Tablet layouts
   - Desktop optimization
   - Adaptive components

#### Phase 3: Advanced Features (Low Priority)
**Timeline:** 4-6 months

1. **Video Consultation** (4-6 weeks)
   - WebRTC integration
   - Video call UI
   - Recording (if needed)

2. **Wearable Integration** (6-8 weeks)
   - Device SDK integration
   - Data sync
   - Real-time monitoring

3. **AI Features** (8-12 weeks)
   - ML model integration
   - Personalized recommendations
   - Health insights

4. **Social Features** (6-8 weeks)
   - User connections
   - Sharing
   - Challenges

### 5.3 Technical Debt & Improvements

#### High Priority Technical Debt
1. **Theme System:** Complete dark mode implementation
2. **Color Usage:** Replace hardcoded colors with theme constants
3. **Error Handling:** Add comprehensive error handling
4. **Testing:** Add unit and widget tests

#### Medium Priority Improvements
1. **Code Documentation:** Add comprehensive comments
2. **Performance:** Profile and optimize
3. **Security:** Implement secure storage
4. **Localization:** Add i18n support

#### Low Priority Enhancements
1. **Animations:** Enhance micro-interactions
2. **Analytics:** Add usage tracking
3. **Crash Reporting:** Implement crash reporting
4. **CI/CD:** Set up automated testing and deployment

---

## 6. System Architecture Diagram

### 6.1 High-Level Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                        User Interface                         │
│  (Screens, Widgets, Navigation)                              │
└───────────────────────┬─────────────────────────────────────┘
                        │
┌───────────────────────▼─────────────────────────────────────┐
│                    State Management                          │
│              (Riverpod Providers)                            │
└───────────────────────┬─────────────────────────────────────┘
                        │
        ┌───────────────┼───────────────┐
        │               │               │
┌───────▼──────┐ ┌─────▼──────┐ ┌─────▼──────┐
│   Business    │ │   Data     │ │   Theme    │
│    Logic      │ │  Models    │ │   System   │
└───────┬──────┘ └─────┬──────┘ └────────────┘
        │               │
┌───────▼───────────────▼─────────────────────────────────────┐
│                    Data Layer                                │
│  (Database Helper, SharedPreferences, Future: API Client)    │
└───────────────────────┬─────────────────────────────────────┘
                        │
        ┌───────────────┼───────────────┐
        │               │               │
┌───────▼──────┐ ┌─────▼──────┐ ┌─────▼──────┐
│   SQLite     │ │  Shared     │ │   Backend  │
│  Database    │ │ Preferences │ │    API     │
│              │ │             │ │  (Future)  │
└──────────────┘ └─────────────┘ └────────────┘
```

### 6.2 Data Flow

```
User Action
    ↓
UI Widget
    ↓
Provider (State Management)
    ↓
Business Logic / Service
    ↓
Data Layer (Database/API)
    ↓
Model Update
    ↓
Provider State Update
    ↓
UI Rebuild
```

---

## 7. Technology Decisions

### 7.1 Framework Choice: Flutter
**Rationale:**
- Cross-platform development (iOS, Android, Web, Desktop)
- Single codebase for all platforms
- Excellent performance
- Rich widget library
- Strong community support

### 7.2 State Management: Riverpod
**Rationale:**
- Type-safe state management
- Dependency injection
- Easy testing
- Better than Provider (no BuildContext needed)
- Compile-time safety

### 7.3 Database: SQLite (sqflite)
**Rationale:**
- Local data persistence
- Offline-first capability
- Relational data structure
- Lightweight and fast
- Well-established Flutter package

### 7.4 Architecture: Feature-Based
**Rationale:**
- Clear separation of concerns
- Easy to scale
- Team collaboration friendly
- Feature isolation
- Maintainable codebase

---

## 8. Security Considerations

### 8.1 Current Implementation
- **Data Storage:** Local SQLite database
- **Credentials:** Not securely stored (needs implementation)
- **API Communication:** Not implemented (no backend)

### 8.2 Planned Security Measures
1. **Secure Storage:** Use `flutter_secure_storage` for sensitive data
2. **API Security:** HTTPS, JWT tokens, certificate pinning
3. **Data Encryption:** Encrypt sensitive health data
4. **Authentication:** Secure login with password hashing
5. **Privacy:** GDPR compliance, data anonymization

---

## 9. Conclusion

The Sehati Health App has a solid foundation with a well-structured architecture, comprehensive UI implementation, and modular design. The application is ready for backend integration and feature completion. Key priorities include completing dark mode, implementing real authentication, and adding data persistence. The feature-based architecture supports scalability and maintainability for future growth.

---

## 10. Appendices

### 10.1 Glossary

- **SRS:** Software Requirement Specification
- **UI:** User Interface
- **UX:** User Experience
- **API:** Application Programming Interface
- **JWT:** JSON Web Token
- **CRUD:** Create, Read, Update, Delete
- **FCM:** Firebase Cloud Messaging
- **APNS:** Apple Push Notification Service
- **i18n:** Internationalization
- **WCAG:** Web Content Accessibility Guidelines

### 10.2 References

- Flutter Documentation: https://docs.flutter.dev/
- Riverpod Documentation: https://riverpod.dev/
- Material Design 3: https://m3.material.io/
- SQLite Documentation: https://www.sqlite.org/docs.html

---

**Document End**

