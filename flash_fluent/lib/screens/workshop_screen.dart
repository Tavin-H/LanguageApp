import 'package:flash_fluent/custom-widgets/styled_button.dart';
import 'package:flash_fluent/utils/app_consts.dart';
import 'package:flash_fluent/utils/json_utils.dart';
import 'package:flash_fluent/custom-widgets/navbar.dart';
import 'package:flash_fluent/utils/user_data.dart';
import 'package:flash_fluent/utils/user_save.dart';
import 'package:flutter/material.dart';

class BookmarkContainer extends StatelessWidget {
  const BookmarkContainer({
    super.key,
    required this.setParentState,
    required this.onRemoveConfirm,
    required this.goToPush,
    required this.title,
    required this.isStory,
  });
  final Function() setParentState;
  final Function() onRemoveConfirm;
  final Function() goToPush;
  final bool isStory;
  final String title;

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
                  text: title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColours.orange,
                  ),
                ),
                isStory
                    ? TextSpan(text: '" from your bookmarked stories?')
                    : TextSpan(text: '" from your bookmarked lessons?'),
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
                onRemoveConfirm();
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
                title,
                style: TextStyle(fontSize: 18, color: AppColours.foreground),
              ),
              Expanded(child: Container()),
              StyledButton(
                text: "Review",
                func: () {
                  goToPush();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WorkshopScreen extends StatefulWidget {
  const WorkshopScreen({super.key});

  @override
  State<WorkshopScreen> createState() => _WorkshopScreenState();
}

class _WorkshopScreenState extends State<WorkshopScreen> {
  List<String> bookmarkTypes = ["Lessons", "Stories", "Audio"];
  String selectedBookmarkType = "Lessons";
  final UserSaveSerice _saveService = UserSaveSerice.instance;
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ValueListenableBuilder(
                        valueListenable: lessonBookmarks,
                        builder: (context, bookmarks, child) {
                          return Text(
                            selectedBookmarkType == "Lessons"
                                ? "Your bookmarks (${lessonBookmarks.value.length})"
                                : "Your bookmarks (${storyBookmarks.value.length})",
                            style: TextStyle(
                              color: AppColours.foreground,
                              fontSize: 20,
                            ),
                          );
                        },
                      ),

                      Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                          color: AppColours.background,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColours.background2,
                            width: 3,
                          ),
                        ),
                        child: Center(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectedBookmarkType,
                              focusColor: Colors.transparent,

                              onChanged: (newValue) {
                                setState(() {
                                  selectedBookmarkType = newValue!;
                                });
                                print(newValue);
                              },
                              hint: Text(
                                selectedBookmarkType,
                                style: TextStyle(color: AppColours.foreground),
                              ),
                              icon: const SizedBox.shrink(),
                              borderRadius: BorderRadius.circular(10),
                              items: bookmarkTypes.map((item) {
                                return DropdownMenuItem(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: TextStyle(
                                      color: (selectedBookmarkType == item)
                                          ? AppColours.orange
                                          : AppColours.foreground,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Container(
                    height: 3,
                    width: double.infinity,
                    color: AppColours.background2,
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),

            if (selectedBookmarkType == "Lessons")
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: (lessonBookmarks),
                  builder: (context, bookmarks, child) {
                    return ListView.builder(
                      itemCount: bookmarks.length,
                      itemBuilder: (context, index) {
                        Lesson lesson = bookmarks[index];
                        return BookmarkContainer(
                          isStory: false,
                          setParentState: () {
                            setState(() {});
                          },
                          onRemoveConfirm: () {
                            _saveService.saveBookmarkLesson(
                              lesson.title,
                              false,
                            );
                            lessonBookmarks.value.remove(lesson);
                            setState(() {});
                          },
                          goToPush: () {
                            Navigator.pushNamed(
                              context,
                              '/lesson',
                              arguments: lesson,
                            );
                          },
                          title: lesson.title,
                        );
                      },
                    );
                  },
                ),
              ),
            if (selectedBookmarkType == "Stories")
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: (storyBookmarks),
                  builder: (context, bookmarks, child) {
                    return ListView.builder(
                      itemCount: bookmarks.length,
                      itemBuilder: (context, index) {
                        Story story = bookmarks[index];
                        return BookmarkContainer(
                          isStory: true,
                          setParentState: () {
                            setState(() {});
                          },
                          onRemoveConfirm: () {
                            storyBookmarks.value.remove(story);
                            _saveService.saveBookmarkLesson(story.title, false);
                            setState(
                              () {},
                            ); //Kinda janky but reloads the widget to reflect the change
                          },
                          goToPush: () {
                            Navigator.pushNamed(
                              context,
                              '/story',
                              arguments: story,
                            );
                          },
                          title: story.title,
                        );
                      },
                    );
                  },
                ),
              ),
            if (selectedBookmarkType == "Audio")
              Center(
                child: Text(
                  "Coming soon!!!",
                  style: TextStyle(
                    color: AppColours.background2,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            if (selectedBookmarkType == "Audio") Expanded(child: Container()),

            Navbar(),
          ],
        ),
      ),
    );
  }
}
