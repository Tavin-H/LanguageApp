import 'package:flash_fluent/screens/bookmarks_screen.dart';
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

  final List<dynamic> rawGrammarLessons = data['grammar-lessons'] as List;
  List<Lesson> grammarLessons = rawGrammarLessons.map((l) => Lesson.fromJson(l)).toList();

  final List<dynamic> rawVocabLessons = data['vocab-lessons'] as List;
  List<Lesson> vocabLessons = rawVocabLessons.map((l) => Lesson.fromJson(l)).toList();

  runApp(MyApp(grammarLessons: grammarLessons, vocabLessons: vocabLessons, ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.grammarLessons, required this.vocabLessons});

  final List<Lesson> grammarLessons;
	final List<Lesson> vocabLessons;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/learn': (context) => LearnScreen(lessons: grammarLessons),
        '/vocab': (context) => const VocabLesson(),
        '/grammar': (context) => const GrammarLesson(),
        '/grammar_diff': (context) => const GrammarDiffLesson(),
        '/vocab_diff': (context) => const VocabDiffLesson(),
        '/bookmarks': (context) => const BookmarksScreen(),
      },
    );
  }
}
