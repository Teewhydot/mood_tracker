enum Mood { happy, calm, sad, annoyed, angry }



class MoodEntry {
  final String id;
  final Mood mood;
  final DateTime timestamp;

  MoodEntry({required this.id, required this.mood, required this.timestamp});
}