import 'dart:ui';

import 'package:mood_tracker/models.dart';

extension MoodProperties on Mood {
  String get label {
    switch (this) {
      case Mood.happy:
        return 'Happy';
      case Mood.calm:
        return 'Calm';
      case Mood.sad:
        return 'Sad';
      case Mood.annoyed:
        return "Annoyed";
      case Mood.angry:
        return "Angry";
    }
  }


  Color get color {
    switch (this) {
      case Mood.happy:
        return const Color(0xFFFFB300);  // Warm amber/gold - joyful, energetic
      case Mood.calm:
        return const Color(0xFF42A5F5);  // Soft blue - peaceful, serene
      case Mood.sad:
        return const Color(0xFF78909C);  // Blue-grey - melancholic, subdued
      case Mood.annoyed:
        return const Color(0xFFFF7043);  // Coral orange - irritated, frustrated
      case Mood.angry:
        return const Color(0xFFE53935);  // Bold red - intense, angry
    }
  }
}