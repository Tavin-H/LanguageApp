import 'package:flutter/material.dart';

class VocabLesson extends StatefulWidget {
  const VocabLesson({super.key});

  @override
  State<VocabLesson> createState() => _VocabLessonState();
}

class _VocabLessonState extends State<VocabLesson> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Vocab Lesson"),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("back"),
            ),
          ],
        ),
      ),
    );
  }
}
