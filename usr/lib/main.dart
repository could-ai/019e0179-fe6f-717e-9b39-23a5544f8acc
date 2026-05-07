import 'package:flutter/material.dart';

void main() {
  runApp(const LessonApp());
}

class LessonContent {
  final int index;
  final String title;
  final String body;

  const LessonContent({
    required this.index,
    required this.title,
    required this.body,
  });
}

class Lesson {
  final String id;
  final String title;
  final String description;
  final List<LessonContent> contents;

  const Lesson({
    required this.id,
    required this.title,
    required this.description,
    required this.contents,
  });
}

// Sample Data
final List<Lesson> sampleLessons = [
  Lesson(
    id: '1',
    title: 'Introduction to Flutter',
    description: 'Learn the basics of the Flutter framework.',
    contents: [
      const LessonContent(index: 1, title: 'What is Flutter?', body: 'Flutter is a UI toolkit...'),
      const LessonContent(index: 2, title: 'Widgets Basics', body: 'Everything is a widget...'),
      const LessonContent(index: 3, title: 'Stateful vs Stateless', body: 'Understanding state...'),
    ],
  ),
  Lesson(
    id: '2',
    title: 'Dart Programming',
    description: 'Master the Dart language used in Flutter.',
    contents: [
      const LessonContent(index: 1, title: 'Variables and Types', body: 'Dart is strongly typed...'),
      const LessonContent(index: 2, title: 'Functions', body: 'Functions are first-class citizens...'),
    ],
  ),
];

class LessonApp extends StatelessWidget {
  const LessonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lessons App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LessonListScreen(),
      },
    );
  }
}

class LessonListScreen extends StatelessWidget {
  const LessonListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Courses & Lessons'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: sampleLessons.length,
        itemBuilder: (context, index) {
          final lesson = sampleLessons[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 16.0),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16.0),
              title: Text(
                lesson.title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(lesson.description),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LessonDetailScreen(lesson: lesson),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class LessonDetailScreen extends StatelessWidget {
  final Lesson lesson;

  const LessonDetailScreen({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lesson.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: lesson.contents.length,
        itemBuilder: (context, idx) {
          final content = lesson.contents[idx];
          return Card(
            margin: const EdgeInsets.only(bottom: 12.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: Text(
                          content.index.toString(),
                          style: const TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          content.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    content.body,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
