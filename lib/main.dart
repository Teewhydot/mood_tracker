import 'package:flutter/material.dart';
import 'package:mood_tracker/extensions.dart';
import 'package:mood_tracker/models.dart';
import 'package:mood_tracker/widgets/mood_face.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mood Tracker',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFFFAFBFF),
      ),
      home: const MoodTrackerScreen(),
    );
  }
}




class MoodTrackerScreen extends StatefulWidget {
  const MoodTrackerScreen({super.key});

  @override
  State<MoodTrackerScreen> createState() => _MoodTrackerScreenState();
}

class _MoodTrackerScreenState extends State<MoodTrackerScreen> {
  final List<MoodEntry> _entries = [];
  String? _animatedEntryId;
  Mood? _lastLoggedMood;

  void _logMood(Mood mood) {
    final entry = MoodEntry(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      mood: mood,
      timestamp: DateTime.now(),
    );

    setState(() {
      _entries.insert(0, entry);
      _lastLoggedMood = mood;
      _animatedEntryId = entry.id;
    });

    Future.delayed(const Duration(milliseconds: 260), () {
      if (!mounted) return;
      setState(() {
        _animatedEntryId = null;
      });
    });
  }

  void _animateEntryTap(String entryId) {
    setState(() {
      _animatedEntryId = entryId;
    });
    Future.delayed(const Duration(milliseconds: 260), () {
      if (!mounted) return;
      setState(() {
        _animatedEntryId = null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final recentEntries = _entries.take(7).toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mood Tracker'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Text(
                'Tap how you feel right now and track your mood over the last 7 entries.',
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              const SizedBox(height: 24),
              _buildMoodButtons(),
              const SizedBox(height: 28),
              _buildStatusCard(),
              const SizedBox(height: 28),
              const Text(
                'Recent mood timeline',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: recentEntries.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(
                              Icons.history,
                              size: 52,
                              color: Colors.black26,
                            ),
                            SizedBox(height: 12),
                            Text(
                              'No mood entries yet.\nTap a mood to start tracking.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: recentEntries.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          final entry = recentEntries[index];
                          final isAnimated = entry.id == _animatedEntryId;
                          return GestureDetector(
                            onTap: () => _animateEntryTap(entry.id),
                            child: AnimatedScale(
                              duration: const Duration(milliseconds: 240),
                              scale: isAnimated ? 0.95 : 0.90,
                              child: _buildTimelineCard(entry, isAnimated),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMoodButtons() {
    return Wrap(
      runSpacing: 6,
      spacing: 12,
      children: Mood.values.map((mood) {
        return ElevatedButton(
          onPressed: () => _logMood(mood),
          style: ElevatedButton.styleFrom(
            backgroundColor: mood.color.withOpacity(0.3),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(26),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MoodFace(mood: mood, size: 44),
              const SizedBox(height: 6),
              Text(
                mood.label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildStatusCard() {
    final moodText = _lastLoggedMood != null
        ? 'Last logged: ${_lastLoggedMood!.label}'
        : 'No mood logged yet';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          const BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Mood snapshot',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          Text(
            moodText,
            style: const TextStyle(fontSize: 15, color: Colors.black87),
          ),
          const SizedBox(height: 12),
          if (_entries.isNotEmpty)
            Text(
              'Total entries: ${_entries.length}',
              style: const TextStyle(color: Colors.black54),
            ),
        ],
      ),
    );
  }

  Widget _buildTimelineCard(MoodEntry entry, bool isSelected) {
    return IntrinsicHeight(
      child: Container(
        width: 200,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: isSelected
              ? entry.mood.color.withAlpha((0.14 * 255).round())
              : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected ? entry.mood.color : Colors.black12,
            width: isSelected ? 1.6 : 1.0,
          ),
          boxShadow: [
            const BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.04),
              blurRadius: 12,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MoodFace(mood: entry.mood, size: 56),
            const SizedBox(height: 12),
            Text(
              entry.mood.label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: entry.mood.color,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _formattedTime(entry.timestamp),
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
      
          ],
        ),
      ),
    );
  }

  String _formattedTime(DateTime timestamp) {
    final hour = timestamp.hour.toString().padLeft(2, '0');
    final minute = timestamp.minute.toString().padLeft(2, '0');
    final day = timestamp.day.toString().padLeft(2, '0');
    final month = timestamp.month.toString().padLeft(2, '0');
    return '$hour:$minute • $month/$day';
  }
}
