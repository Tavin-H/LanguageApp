import 'package:flash_fluent/screens/grammar_diff_lesson.dart';
import 'package:flash_fluent/screens/grammar_lesson.dart';
import 'package:flash_fluent/screens/home_screen.dart';
import 'package:flash_fluent/screens/learn_screen.dart';
import 'package:flash_fluent/screens/vocab_diff_lesson.dart';
import 'package:flash_fluent/screens/vocab_lesson.dart';
import 'package:flutter/material.dart';

/////dart format .

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/learn': (context) => const LearnScreen(),
        '/vocab': (context) => const VocabLesson(),
        '/grammar': (context) => const GrammarLesson(),
        '/grammar_diff': (context) => const GrammarDiffLesson(),
        '/vocab_diff': (context) => const VocabDiffLesson(),
      },
    );
  }
}
