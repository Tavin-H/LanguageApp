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
    required this.setParentState,
  });
  final Lesson lesson;
  final Function() setParentState;

  void showConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColours.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(10),
          ),
          title: Text(
            "Remove bookmark?",
            style: TextStyle(
              color: AppColours.foreground,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text.rich(
            TextSpan(
              text: 'Are you sure you want to remove "', // Default style
              style: TextStyle(fontSize: 18, color: AppColours.foreground),
              children: <TextSpan>[
                TextSpan(
                  text: lesson.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColours.orange,
                  ),
                ),
                TextSpan(text: '" from your bookmarked lessons?'),
              ],
            ),
          ),

          /*
					Text(
            "Are you sure you want to remove \"${bookmark.lesson.title}\" from your bookmarked lessons?",
            style: TextStyle(color: AppColours.foreground),
          ),
					*/
          actions: <Widget>[
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                height: 40,
                width: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusGeometry.circular(10),
                  color: AppColours.orange,
                ),
                child: Center(child: Text("No")),
              ),
            ),
            InkWell(
              onTap: () {
                userBookmarks.remove(lesson);
                setParentState();
                Navigator.of(context).pop();
              },
              child: Container(
                height: 40,
                width: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusGeometry.circular(10),
                  border: Border.all(width: 3, color: AppColours.background2),
                ),
                child: Center(
                  child: Text(
                    "Yes",
                    style: TextStyle(color: AppColours.foreground),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
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
                onPressed: () {
                  showConfirmDialog(context);
                },
                icon: Icon(Icons.bookmark, color: AppColours.orange),
              ),
              Text(
                lesson.title,
                style: TextStyle(fontSize: 18, color: AppColours.foreground),
              ),
              Expanded(child: Container()),
              StyledButton(
                text: "Review",
                func: () {
                  Navigator.pushNamed(context, '/lesson', arguments: lesson);
                },
              ),
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
                  SizedBox(height: 20),
                  Text(
                    "Your bookmarks (${userBookmarks.length})",
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
                  Lesson lesson = userBookmarks[index];
                  return BookmarkContainer(
                    setParentState: () {
                      setState(() {});
                    },
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
