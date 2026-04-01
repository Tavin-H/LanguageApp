import 'package:flash_fluent/custom-widgets/navbar.dart';
import 'package:flash_fluent/custom-widgets/outline_button.dart';
import 'package:flash_fluent/custom-widgets/styled_button.dart';
import 'package:flash_fluent/utils/app_consts.dart';
import 'package:flash_fluent/utils/json_utils.dart';
import 'package:flash_fluent/utils/user_data.dart';
import 'package:flutter/material.dart';

class LessonContainer extends StatelessWidget {
  const LessonContainer({
    super.key,
    required this.lesson,
    required this.setParentState,
    required this.moveLessonToEnd,
  });
  final Lesson lesson;
  final void Function() setParentState;
  final void Function(Lesson) moveLessonToEnd;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: lesson.completed,
      builder: (context, completed, child) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 70,
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          lesson.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColours.orange,
                          ),
                        ),
                        Text(
                          lesson.subtitle,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColours.foreground,
                          ),
                        ),
                      ],
                    ),
                    /*
                    StyledButton(
                      text: "Learn",
                      func: () {
                        Navigator.pushNamed(
                          context,
                          '/lesson',
                          arguments: lesson,
                        ).then((_) {
                          if (lesson.completed.value) {
                            moveLessonToEnd(lesson);
                          }

                          setParentState();
                        });
                      },
                    ),
										*/
                    OutlineButton(
                      text: "Learn",
                      onpressed: () {
                        Navigator.pushNamed(
                          context,
                          '/lesson',
                          arguments: lesson,
                        ).then((_) {
                          if (lesson.completed.value) {
                            moveLessonToEnd(lesson);
                          }

                          setParentState();
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            if (completed)
              Positioned(
                top: -5,
                left: -5,
                child: Icon(
                  Icons.check_circle_rounded,
                  color: AppColours.green,
                ),
              ),
          ],
        );
      },
    );
  }
}

class LearnScreen extends StatefulWidget {
  const LearnScreen({super.key, required this.chapter});
  final ChapterData chapter;

  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  void moveLessonToEnd(Lesson lesson) {
    widget.chapter.lessons.remove(lesson);
    widget.chapter.lessons.add(lesson);
    widget.chapter.updateProgess();
  }

  @override
  Widget build(BuildContext context) {
    Lesson suggetedVocab = widget.chapter.lessons.firstWhere(
      (l) => (!l.completed.value && l.type == LessonType.vocab),
      orElse: () => widget.chapter.lessons[0],
    );
    Lesson suggetedGrammar = widget.chapter.lessons.firstWhere(
      (l) => (!l.completed.value && l.type == LessonType.grammar),
      orElse: () => widget.chapter.lessons[0],
    );
    return Scaffold(
      backgroundColor: AppColours.background,
      body: Container(
        decoration: BoxDecoration(color: AppColours.background),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back, color: AppColours.foreground),
              ),
              Padding(
                padding: EdgeInsetsGeometry.fromLTRB(20, 0, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your suggested next lessons",
                      style: TextStyle(
                        color: AppColours.foreground,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      height: 3,
                      width: double.infinity,
                      color: AppColours.background2,
                    ),
                    SizedBox(height: 10),

                    Text(
                      "Grammar",
                      style: TextStyle(color: AppColours.foreground2),
                    ),
                    LessonContainer(
                      lesson: suggetedGrammar,
                      setParentState: () {
                        setState(() {});
                      },
                      moveLessonToEnd: moveLessonToEnd,
                    ),
                    Text(
                      "Vocab",
                      style: TextStyle(color: AppColours.foreground2),
                    ),
                    LessonContainer(
                      lesson: suggetedVocab,
                      setParentState: () {
                        setState(() {});
                      },
                      moveLessonToEnd: moveLessonToEnd,
                    ),
                    SizedBox(height: 40),
                    Text(
                      "All Lessons",
                      style: TextStyle(
                        color: AppColours.foreground,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      height: 3,
                      width: double.infinity,
                      color: AppColours.background2,
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.chapter.lessons.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsetsGeometry.fromLTRB(20, 0, 20, 10),
                      child: LessonContainer(
                        lesson: widget.chapter.lessons[index],
                        setParentState: () {
                          setState(() {});
                        },
                        moveLessonToEnd: moveLessonToEnd,
                      ),
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
