import 'dart:ui';

import 'package:mood_tracker/models.dart';

extension MoodProperties on Mood {
  String get label {
    switch (this) {
      case Mood.happy:
        return 'Happy';
      case Mood.calm:
        return 'Calm';
      case Mood.neutral:
        return 'Neutral';
      case Mood.tired:
        return 'Tired';
      case Mood.stressed:
        return 'Stressed';
      case Mood.angry:
        return 'Angry';
    }
  }

  String get emoji {
    switch (this) {
      case Mood.happy:
        return '😄';
      case Mood.calm:
        return '😌';
      case Mood.neutral:
        return '😐';
      case Mood.tired:
        return '😴';
      case Mood.stressed:
        return '😣';
      case Mood.angry:
        return '😠';
    }
  }

  Color get color {
    switch (this) {
      case Mood.happy:
        return const Color(0xFF4CAF50);
      case Mood.calm:
        return const Color(0xFF2196F3);
      case Mood.neutral:
        return const Color(0xFF9E9E9E);
      case Mood.tired:
        return const Color(0xFFFFA726);
      case Mood.stressed:
        return const Color(0xFFEF5350);
      case Mood.angry:
        return const Color(0xFFF44336);
    }
  }
}