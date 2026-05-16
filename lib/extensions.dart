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
        return const Color(0xFF4CAF50);
      case Mood.calm:
        return const Color(0xFF2196F3);
      case Mood.sad:
        return const Color(0xFF9E9E9E);
      case Mood.annoyed:
        return const Color.fromARGB(255, 255, 152, 0);  // Orange color, fully opaque
      case Mood.angry:
        return const Color.fromARGB(255, 232, 3, 3);  // Purple
    }
  }
}