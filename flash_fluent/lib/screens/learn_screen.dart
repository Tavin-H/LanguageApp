import 'package:flash_fluent/custom-widgets/navbar.dart';
import 'package:flash_fluent/custom-widgets/styled_button.dart';
import 'package:flash_fluent/utils/app_consts.dart';
import 'package:flash_fluent/utils/json_utils.dart';
import 'package:flutter/material.dart';

class LessonContainer extends StatelessWidget {
  const LessonContainer({
    super.key,
    required this.lesson,
    required this.setParentState,
  });
  final Lesson lesson;
  final void Function() setParentState;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: lesson.completed,
      builder: (context, completed, child) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
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
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColours.foreground,
                      ),
                    ),
                    StyledButton(
                      text: "Learn",
                      func: () {
                        Navigator.pushNamed(
                          context,
                          '/lesson',
                          arguments: lesson,
                        ).then((_) {
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
                  color: AppColours.orange,
                ),
              ),
          ],
        );
      },
    );
  }
}

class LearnScreen extends StatefulWidget {
  const LearnScreen({
    super.key,
    required this.grammarLessons,
    required this.vocabLessons,
  });
  final List<Lesson> grammarLessons;
  final List<Lesson> vocabLessons;

  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  @override
  Widget build(BuildContext context) {
    Lesson suggetedVocab = widget.vocabLessons.firstWhere(
      (l) => !l.completed.value,
      orElse: () => widget.vocabLessons[0],
    );
    Lesson suggetedGrammar = widget.grammarLessons.firstWhere(
      (l) => !l.completed.value,
      orElse: () => widget.grammarLessons[0],
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
                    LessonContainer(
                      lesson: suggetedGrammar,
                      setParentState: () {
                        setState(() {});
                      },
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
                    ),
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
              SizedBox(height: 5),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.grammarLessons.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsetsGeometry.fromLTRB(40, 0, 40, 15),
                      child: LessonContainer(
                        lesson: widget.grammarLessons[index],
                        setParentState: () {
                          setState(() {});
                        },
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
