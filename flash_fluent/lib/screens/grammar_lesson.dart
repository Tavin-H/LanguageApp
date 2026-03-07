import 'package:flutter/material.dart';

class GrammarLesson extends StatefulWidget {
  const GrammarLesson({super.key});

  @override
  State<GrammarLesson> createState() => _GrammarLessonState();
}

class _GrammarLessonState extends State<GrammarLesson> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("GrammarLesson"),
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
