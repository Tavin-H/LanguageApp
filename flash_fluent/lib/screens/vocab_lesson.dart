import 'package:flash_fluent/utils/json_utils.dart';
import 'package:flutter/material.dart';

class VocabLesson extends StatefulWidget {
  const VocabLesson({super.key});
  @override
  State<VocabLesson> createState() => _VocabLessonState();
}

class _VocabLessonState extends State<VocabLesson> {
  int page = 0;

  @override
  Widget build(BuildContext context) {
    final Lesson lesson = ModalRoute.of(context)!.settings.arguments as Lesson;
    void nextPage() {
      if (page < lesson.pages.length - 1) {
        setState(() {
          page++;
        });
      } else {
        //End lesson;
        Navigator.pop(context);
      }
    }

    void previousPage() {
      if (page > 0) {
        setState(() {
          page--;
        });
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(lesson.title, style: TextStyle(fontSize: 25.0)),
            Expanded(
              child: ListView.builder(
                physics:
                    const ClampingScrollPhysics(), // Stop it from stretching!
                itemCount: lesson.pages[page].components.length,
                itemBuilder: (context, index) {
                  Component component = lesson.pages[page].components[index];
                  return Padding(
                    padding: EdgeInsets.fromLTRB(
                      20,
                      0,
                      10,
                      component.bottomMargin,
                    ),
                    child: convertJsonComponentToWidget(component),
                  );
                },
              ),
            ),
            ElevatedButton(onPressed: nextPage, child: Text("next")),
            ElevatedButton(onPressed: previousPage, child: Text("previous")),
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
