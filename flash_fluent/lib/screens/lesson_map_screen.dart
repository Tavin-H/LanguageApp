import 'package:flash_fluent/utils/json_utils.dart';
import 'package:flutter/material.dart';

class LessonMapContainer extends StatelessWidget {
  const LessonMapContainer({super.key, required this.lesson});
  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(lesson.title),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/vocab', arguments: lesson);
          },
          child: Text("Learn!"),
        ),
      ],
    );
  }
}

class LessonMapScreen extends StatefulWidget {
  const LessonMapScreen({super.key, required this.grammarLessons});
  final List<Lesson> grammarLessons;

  @override
  State<LessonMapScreen> createState() => _LessonMapScreenState();
}

class _LessonMapScreenState extends State<LessonMapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text("Vocabulary Lessons:"),
            Expanded(
              child: ListView.builder(
                itemCount: widget.grammarLessons.length,
                itemBuilder: (context, index) {
                  return LessonMapContainer(
                    lesson: widget.grammarLessons[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
