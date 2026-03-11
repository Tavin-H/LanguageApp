import 'package:flash_fluent/custom-widgets/styled_button.dart';
import 'package:flash_fluent/utils/app_consts.dart';
import 'package:flash_fluent/utils/json_utils.dart';
import 'package:flash_fluent/utils/user_data.dart';
import 'package:flutter/material.dart';

class LearnLesson extends StatefulWidget {
  const LearnLesson({super.key});
  @override
  State<LearnLesson> createState() => _LearnLessonState();
}

class _LearnLessonState extends State<LearnLesson> {
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

    void makeBookmark() {
      userBookmarks.add(Bookmark(page: page, lesson: lesson));
    }

    return Scaffold(
      backgroundColor: AppColours.background,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back, color: AppColours.foreground),
                ),

                Text(
                  lesson.title,
                  style: TextStyle(
                    fontSize: 25.0,
                    color: AppColours.foreground,
                  ),
                ),
                IconButton(
                  onPressed: makeBookmark,
                  icon: Icon(
                    Icons.bookmark_outline,
                    color: AppColours.foreground,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
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
                      20,
                      component.bottomMargin,
                    ),
                    child: convertJsonComponentToWidget(component),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                StyledButton(text: "previous", func: previousPage),
                StyledButton(text: "Next", func: nextPage),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
