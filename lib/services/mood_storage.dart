import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mood_tracker/models.dart';

class MoodStorage {
  static const String _entriesKey = 'mood_entries';

  /// Save mood entries to local storage
  static Future<void> saveEntries(List<MoodEntry> entries) async {
    final prefs = await SharedPreferences.getInstance();
    
    // Convert entries to JSON
    final jsonList = entries.map((entry) => {
      'id': entry.id,
      'mood': entry.mood.name,  // Stores as string: 'happy', 'calm', etc.
      'timestamp': entry.timestamp.toIso8601String(),
    }).toList();
    
    // Save as JSON string
    await prefs.setString(_entriesKey, jsonEncode(jsonList));
  }

  /// Load mood entries from local storage
  static Future<List<MoodEntry>> loadEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_entriesKey);
    
    if (jsonString == null) {
      return [];
    }
    
    try {
      final jsonList = jsonDecode(jsonString) as List;
      
      return jsonList.map((json) {
        return MoodEntry(
          id: json['id'] as String,
          mood: _parseMood(json['mood'] as String),
          timestamp: DateTime.parse(json['timestamp'] as String),
        );
      }).toList();
    } catch (e) {
      // If parsing fails, return empty list
      return [];
    }
  }

  /// Clear all stored entries
  static Future<void> clearEntries() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_entriesKey);
  }

  /// Parse mood string to Mood enum
  static Mood _parseMood(String moodString) {
    return Mood.values.firstWhere(
      (mood) => mood.name == moodString,
      orElse: () => Mood.happy,  // Default fallback
    );
  }
}
