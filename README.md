# High School Manager - Trilingual Edition

**A beautiful, modern school management application built with Flutter for Windows and Android.**

## ✨ Features

### 🌍 Multilingual Support
- **English** 🇺🇸
- **العربية (Arabic)** 🇸🇦
- **Français (French)** 🇫🇷

### 📱 Cross-Platform
- ✅ Android (APK)
- ✅ Windows Desktop (Executable)

### 🎯 Core Features
- 📊 **Dashboard**: Real-time statistics and overview
- 👥 **User Management**: Add, edit, delete users with 5 roles
- 🏫 **Class Management**: Manage classes and student groups
- 📅 **Schedule**: View and manage class schedules
- ⚙️ **Settings**: Language, theme, profile management
- 🎨 **Beautiful UI**: Material Design 3
- 🌓 **Dark/Light Theme**: System theme support
- 💾 **Local Storage**: Data persisted locally

### 👥 User Roles (5 Types)
1. Administrator
2. Teacher
3. Student
4. Parent
5. Staff

## 📥 Download Ready App

### Android APK
- **Location**: `build/app/outputs/flutter-apk/app-release.apk`
- **Installation**: Download and install directly
- **Requirements**: Android 5.0+

### Windows Executable
- **Location**: `build/windows/x64/runner/Release/`
- **Installation**: Extract and run `high_school_manager.exe`
- **Requirements**: Windows 10/11

## 🚀 Quick Start

### Prerequisites
- Flutter SDK >= 3.0.0
- Android Studio (for Android)
- Visual Studio (optional, for Windows)

### Setup
```bash
# Clone repository
git clone https://github.com/TouhamiA/high-school-manager.git
cd high-school-manager

# Get dependencies
flutter pub get

# Run on device
flutter run

# Build for release
flutter build apk --release        # Android
flutter build windows --release    # Windows
```

## 🔐 Demo Credentials

| Email | Role | Phone |
|-------|------|-------|
| admin@school.com | Administrator | +212 6 12 34 56 78 |
| fatima@school.com | Teacher | +212 6 87 65 43 21 |
| student1@school.com | Student | +212 6 55 55 55 55 |
| parent@school.com | Parent | +212 6 99 99 99 99 |
| staff@school.com | Staff | +212 6 77 77 77 77 |
| zahra@school.com | Teacher | +212 6 11 11 11 11 |
| student2@school.com | Student | +212 6 22 22 22 22 |
| parent2@school.com | Parent | +212 6 33 33 33 33 |
| staff2@school.com | Staff | +212 6 44 44 44 44 |
| layla@school.com | Teacher | +212 6 55 66 77 88 |

## 📁 Project Structure

```
lib/
├── main.dart
├── l10n/
│   └── app_localizations.dart
├── models/
│   └── user_model.dart
├── providers/
│   ├── locale_provider.dart
│   ├── theme_provider.dart
│   └── user_provider.dart
├── screens/
│   ├── splash_screen.dart
│   ├── login_screen.dart
│   ├── home_screen.dart
│   └── tabs/
│       ├── dashboard_tab.dart
│       ├── users_tab.dart
│       ├── classes_tab.dart
│       ├── schedule_tab.dart
│       └── settings_tab.dart
└── widgets/
    └── user_dialog.dart

assets/
└── l10n/
    ├── en.json
    ├── ar.json
    └── fr.json
```

## ✏️ Customization

### Add/Modify Users
Edit `lib/providers/user_provider.dart`

### Change Colors
Edit `lib/main.dart` (seedColor)

### Modify Translations
Edit `assets/l10n/*.json` files

## 📝 License

MIT License

## 🎉 Version

**1.0.0** - Production Ready ✅
