import 'package:flash_fluent/custom-widgets/navbar.dart';
import 'package:flash_fluent/custom-widgets/styled_button.dart';
import 'package:flash_fluent/utils/app_consts.dart';
import 'package:flash_fluent/utils/json_utils.dart';
import 'package:flutter/material.dart';

class LessonContainer extends StatelessWidget {
  const LessonContainer({super.key, required this.lesson});
  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: AppColours.background,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColours.background2, width: 3),
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.fromLTRB(18, 0, 7, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              lesson.title,
              style: TextStyle(fontSize: 18, color: AppColours.foreground),
            ),
            StyledButton(
              text: "Learn",
              func: () {
                Navigator.pushNamed(context, '/lesson', arguments: lesson);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class LearnScreen extends StatelessWidget {
  const LearnScreen({
    super.key,
    required this.grammarLessons,
    required this.vocabLessons,
  });
  final List<Lesson> grammarLessons;
  final List<Lesson> vocabLessons;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.background,
      body: Container(
        decoration: BoxDecoration(color: AppColours.background),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /*
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
						*/
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back, color: AppColours.foreground),
              ),
              Padding(
                padding: EdgeInsetsGeometry.fromLTRB(40, 0, 40, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your suggested next lessons",
                      style: TextStyle(
                        color: AppColours.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Grammar",
                      style: TextStyle(color: AppColours.foreground2),
                    ),
                    LessonContainer(lesson: grammarLessons[0]),
                    Text(
                      "Vocab",
                      style: TextStyle(color: AppColours.foreground2),
                    ),
                    LessonContainer(lesson: vocabLessons[0]),
                    SizedBox(height: 40),
                    Text(
                      "All Lessons",
                      style: TextStyle(
                        color: AppColours.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: grammarLessons.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsetsGeometry.fromLTRB(40, 0, 40, 10),
                      child: LessonContainer(lesson: grammarLessons[index]),
                    );
                  },
                ),
              ),
              Navbar(),
            ],
          ),
        ),
      ),
    );
  }
}
