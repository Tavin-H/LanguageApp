import 'package:flash_fluent/utils/json_utils.dart';
import 'package:flutter/material.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key, required this.lessons});
  final List<Lesson> lessons;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text("Learn"),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/lesson_map');
                //Navigator.pushNamed(context, '/vocab', arguments: lessons[0]);
              },
              child: Text("Vocabulary"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/', arguments: lessons[0]);
              },
              child: Text("Grammar"),
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
