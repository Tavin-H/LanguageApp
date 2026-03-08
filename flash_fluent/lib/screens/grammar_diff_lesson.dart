import 'package:flutter/material.dart';

class GrammarDiffLesson extends StatefulWidget {
  const GrammarDiffLesson({super.key});

  @override
  State<GrammarDiffLesson> createState() => _GrammarDiffLessonState();
}

class _GrammarDiffLessonState extends State<GrammarDiffLesson> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Grammar Diff Lesson"),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("back"),
            ),
            Text("Coming in v0.2"),
          ],
        ),
      ),
    );
  }
}
