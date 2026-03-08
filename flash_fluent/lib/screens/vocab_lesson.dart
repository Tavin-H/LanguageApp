import 'package:flash_fluent/utils/json_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class VocabLesson extends StatefulWidget {
  const VocabLesson({super.key});

  @override
  State<VocabLesson> createState() => _VocabLessonState();
}

class _VocabLessonState extends State<VocabLesson> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: rootBundle.loadString('assets/lessons.json'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            // Data is here! Now we parse it.
            final Map<String, dynamic> data = json.decode(
              snapshot.data.toString(),
            );
            final lessons = data['lessons'] as List;
						Lesson lesson1 = Lesson.fromJson(lessons[0]);
						

            // Now you return the actual UI
            return SafeArea(
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
									Text(lesson1.components[0].content),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
