import 'package:flash_fluent/utils/json_utils.dart';
import 'package:flutter/material.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key, required this.lessons});
  final List<Lesson> lessons;

  @override
  Widget build(BuildContext context) {
    print(lessons[0]);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text("Learn"),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/vocab', arguments: lessons[0]);
              },
              child: Text("Noun"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/grammar', arguments: lessons[0]);
              },
              child: Text("Grammar"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/grammar_diff');
              },
              child: Text("Grammar Dif"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/vocab_diff');
              },
              child: Text("Noun Dif"),
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
