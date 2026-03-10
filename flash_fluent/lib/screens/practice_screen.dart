import 'package:flutter/material.dart';

class PracticeScreen extends StatelessWidget {
  const PracticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text("Practice"),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/flashcard_hub');
                //Navigator.pushNamed(context, '/vocab', arguments: lessons[0]);
              },
              child: Text("Flashcards"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/grammar_diff');
              },
              child: Text("Story"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/grammar_diff');
              },
              child: Text("Audio"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Back"),
            ),
          ],
        ),
      ),
    );
  }
}
