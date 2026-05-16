enum Mood { happy, calm, neutral, tired, stressed, angry }



class MoodEntry {
  final String id;
  final Mood mood;
  final DateTime timestamp;

  MoodEntry({required this.id, required this.mood, required this.timestamp});
}