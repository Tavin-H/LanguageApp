import 'package:flash_fluent/custom-widgets/styled_button.dart';
import 'package:flash_fluent/utils/app_consts.dart';
import 'package:flash_fluent/utils/json_utils.dart';
import 'package:flash_fluent/custom-widgets/navbar.dart';
import 'package:flash_fluent/utils/user_data.dart';
import 'package:flutter/material.dart';

class BookmarkContainer extends StatelessWidget {
  const BookmarkContainer({
    super.key,
    required this.lesson,
    required this.lessonTitle,
  });
  final String lessonTitle;
  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: AppColours.background,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColours.background2, width: 3),
        ),
        child: Padding(
          padding: EdgeInsetsGeometry.fromLTRB(7, 0, 7, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.bookmark, color: AppColours.orange),
              ),
              Text(
                lesson.title,
                style: TextStyle(fontSize: 18, color: AppColours.foreground),
              ),
              Expanded(child: Container()),
              StyledButton(text: "Review", func: () {}),
            ],
          ),
        ),
      ),
    );

    /*

		Padding(
      padding: EdgeInsets.fromLTRB(20, 10, 10, 20),
      child: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(lessonTitle),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/vocab', arguments: lesson);
              },
              child: Text("go to lesson"),
            ),
          ],
        ),
      ),
    );
		*/
  }
}

class WorkshopScreen extends StatefulWidget {
  const WorkshopScreen({super.key});

  @override
  State<WorkshopScreen> createState() => _WorkshopScreenState();
}

class _WorkshopScreenState extends State<WorkshopScreen> {
  @override
  Widget build(BuildContext context) {
    print(userBookmarks.length);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your bookmarks",
                    style: TextStyle(
                      color: AppColours.foreground,
                      fontSize: 20,
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
            Expanded(
              child: ListView.builder(
                itemCount: userBookmarks.length,
                itemBuilder: (context, index) {
                  Lesson lesson = userBookmarks[index].lesson;
                  return BookmarkContainer(
                    lessonTitle: lesson.title,
                    lesson: lesson,
                  );
                },
              ),
            ),
            Navbar(),
          ],
        ),
      ),
    );
  }
}
