# Quick Start Guide - High School Manager

## Step 1: Install Flutter

1. Download Flutter: https://flutter.dev
2. Extract and add to PATH
3. Verify: `flutter --version`

## Step 2: Clone Repository

```bash
git clone https://github.com/TouhamiA/high-school-manager.git
cd high-school-manager
```

## Step 3: Get Dependencies

```bash
flutter pub get
```

## Step 4: Run App

```bash
# On Android device/emulator
flutter run

# On Windows
flutter run -d windows
```

## Step 5: Build for Release

### Android APK
```bash
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk
```

### Windows Executable
```bash
flutter build windows --release
# Output: build/windows/x64/runner/Release/high_school_manager.exe
```

## 🔐 Login Credentials

Any of these emails:
- admin@school.com (Admin)
- fatima@school.com (Teacher)
- student1@school.com (Student)
- parent@school.com (Parent)
- staff@school.com (Staff)

Password: Any value (demo mode)

## 📱 Features

✅ 3 Languages (EN, AR, FR)
✅ 10 Pre-loaded Users
✅ Dashboard with Statistics
✅ User Management (Add/Edit/Delete)
✅ Class Management
✅ Schedule Viewer
✅ Settings & Preferences
✅ Dark/Light Theme
✅ Local Data Storage

## 🆘 Troubleshooting

### Flutter not found
```bash
flutter clean
flutter pub get
```

### Build fails
```bash
flutter clean
flutter pub get
flutter build apk --release
```

## 📖 Documentation

- Full Guide: See README.md
- Setup Guide: See SETUP_GUIDE.md (if present)
- Flutter Docs: https://flutter.dev/docs
