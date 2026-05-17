# Mood Tracker

A Flutter app for tracking daily moods with custom-drawn mood faces using CustomPainter.

## Features

- 5 mood types: Happy, Calm, Sad, Annoyed, Angry
- Custom-drawn mood faces using Flutter's CustomPainter
- Persistent storage with SharedPreferences
- Timeline view of last 7 mood entries
- Smooth animations and interactions

## Installation

### Prerequisites
- Flutter SDK (3.11.0 or higher)
- Dart SDK
- iOS Simulator / Android Emulator / Chrome (for web)

### Steps

1. Clone the repository
```bash
git clone <repository-url>
cd mood_tracker
```

2. Install dependencies
```bash
flutter pub get
```

3. Run the app
```bash
# iOS
flutter run -d ios

# Android
flutter run -d android

# Web
flutter run -d chrome
```

## Project Structure

```
lib/
├── main.dart                 # Main app entry and UI
├── models.dart              # Data models (Mood enum, MoodEntry)
├── extensions.dart          # Mood properties (labels, colors)
├── services/
│   └── mood_storage.dart    # SharedPreferences persistence
└── widgets/
    └── mood_face.dart       # CustomPainter mood faces
```

## Implementation Highlights

### State Management
- Uses StatefulWidget with local state
- Simple and effective for app scope
- Data persists via SharedPreferences

### CustomPainter Mood Faces
- Hand-drawn faces using Canvas primitives
- `drawCircle` for faces and eyes
- `drawArc` for curved features
- `Path` with `lineTo` and `quadraticBezierTo` for eyebrows
- Performance optimized with `shouldRepaint`

### Data Persistence
- Mood entries stored as JSON in SharedPreferences
- Automatic save on mood log
- Loads on app start

## Building for Production

### Web
```bash
flutter build web --release
```

### iOS
```bash
flutter build ios --release
```

### Android
```bash
flutter build apk --release
```
