import 'package:flash_fluent/screens/bookmarks_screen.dart';
import 'package:flash_fluent/screens/flashcard_hub.dart';
import 'package:flash_fluent/screens/flashcard_practice.dart';
import 'package:flash_fluent/screens/home_screen.dart';
import 'package:flash_fluent/screens/learn_screen.dart';
import 'package:flash_fluent/screens/practice_screen.dart';
import 'package:flash_fluent/screens/learn_lesson.dart';
import 'package:flash_fluent/screens/lesson_map_screen.dart';
import 'package:flash_fluent/utils/app_consts.dart';
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
  List<Lesson> grammarLessons = rawGrammarLessons
      .map((l) => Lesson.fromJson(l))
      .toList();

  final List<dynamic> rawVocabLessons = data['vocab-lessons'] as List;
  List<Lesson> vocabLessons = rawVocabLessons
      .map((l) => Lesson.fromJson(l))
      .toList();

  runApp(MyApp(grammarLessons: grammarLessons, vocabLessons: vocabLessons));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.grammarLessons,
    required this.vocabLessons,
  });

  final List<Lesson> grammarLessons;
  final List<Lesson> vocabLessons;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: AppColours.background,
        canvasColor: AppColours.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColours.blue,
          surface: AppColours.background,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),

        //Intermediate screens
        '/learn': (context) => LearnScreen(
          grammarLessons: grammarLessons,
          vocabLessons: vocabLessons,
        ),
        '/practice': (context) => const PracticeScreen(),
        '/lesson_map': (context) =>
            LessonMapScreen(grammarLessons: grammarLessons),
        '/flashcard_hub': (context) => const FlashcardHub(),

        //Action sceens
        '/lesson': (context) => const LearnLesson(),
        '/flashcard_practice': (context) => const FlashcardPractice(),
        '/bookmarks': (context) => const BookmarksScreen(),
      },
    );
  }
}
