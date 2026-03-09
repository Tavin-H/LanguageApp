import 'package:flash_fluent/utils/json_utils.dart';
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
  }
}

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({super.key});

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  @override
  Widget build(BuildContext context) {
    print(userBookmarks.length);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text("Bookmarks:"),
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
