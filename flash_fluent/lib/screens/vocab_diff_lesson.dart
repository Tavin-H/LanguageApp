import 'package:flutter/material.dart';

class VocabDiffLesson extends StatefulWidget {
  const VocabDiffLesson({super.key});

  @override
  State<VocabDiffLesson> createState() => _VocabDiffLessonState();
}

class _VocabDiffLessonState extends State<VocabDiffLesson> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Vocab Diff Lesson"),
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
