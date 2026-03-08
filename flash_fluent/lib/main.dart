import 'package:flash_fluent/screens/grammar_diff_lesson.dart';
import 'package:flash_fluent/screens/grammar_lesson.dart';
import 'package:flash_fluent/screens/home_screen.dart';
import 'package:flash_fluent/screens/learn_screen.dart';
import 'package:flash_fluent/screens/vocab_diff_lesson.dart';
import 'package:flash_fluent/screens/vocab_lesson.dart';
import 'package:flash_fluent/utils/json_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

/////dart format .

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final String response = await rootBundle.loadString('assets/lessons.json');
  final Map<String, dynamic> data = json.decode(response);

  final List<dynamic> rawLessons = data['vocab-lessons'] as List;
  List<Lesson> allLessons = rawLessons.map((l) => Lesson.fromJson(l)).toList();

  runApp(MyApp(lessons: allLessons));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.lessons});

  final List<Lesson> lessons;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(lessons: lessons),
        '/learn': (context) => LearnScreen(lessons: lessons),
        '/vocab': (context) => const VocabLesson(),
        '/grammar': (context) => const GrammarLesson(),
        '/grammar_diff': (context) => const GrammarDiffLesson(),
        '/vocab_diff': (context) => const VocabDiffLesson(),
      },
    );
  }
}
