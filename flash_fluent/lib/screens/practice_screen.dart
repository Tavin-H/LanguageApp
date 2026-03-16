import 'package:flash_fluent/custom-widgets/navbar.dart';
import 'package:flash_fluent/custom-widgets/styled_button.dart';
import 'package:flash_fluent/utils/app_consts.dart';
import 'package:flash_fluent/utils/json_utils.dart';
import 'package:flash_fluent/utils/user_data.dart';
import 'package:flutter/material.dart';

class PracticeContainer extends StatelessWidget {
  const PracticeContainer({
    super.key,
    required this.text,
    required this.icon,
    required this.action,
    required this.color,
    required this.story,
  });
  final void Function() action;
  final String text;
  final Color color;
  final IconData icon;
  final Story story;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: story.completed,
      builder: (context, completed, child) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: Column(
                children: [
                  InkWell(
                    onTap: action,
                    child: SizedBox(
                      height: 80,
                      width: 100,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: color, width: 3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Icon(
                            icon,
                            size: 40,
                            color: AppColours.foreground,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 90,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.library_books,
                          color: AppColours.foreground2,
                          size: 15,
                        ),
                        Text(
                          "${story.storyPages.length}",
                          style: TextStyle(color: AppColours.foreground2),
                        ),
                        Expanded(child: Container()),

                        Icon(
                          Icons.timer,
                          color: AppColours.foreground2,
                          size: 15,
                        ),
                        Text(
                          "3 min",
                          style: TextStyle(color: AppColours.foreground2),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    text,
                    style: TextStyle(
                      color: AppColours.foreground,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            if (completed)
              Positioned(
                top: -5,
                left: -5,
                child: Icon(Icons.check_circle, color: AppColours.green),
              ),
          ],
        );
      },
    );
  }
}

class PracticeScreen extends StatelessWidget {
  const PracticeScreen({super.key, required this.chapter});

  final ChapterData chapter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  "Practice",
                  style: TextStyle(color: AppColours.foreground, fontSize: 20),
                ),
                SizedBox(width: 40),
              ],
            ),
            Center(
              child: StyledButton(
                text: "Flashcards",
                func: () {
                  Navigator.pushNamed(context, '/flashcard_hub');
                },
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Stories",
                style: TextStyle(color: AppColours.foreground2, fontSize: 18),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ListView.builder(
                  clipBehavior: Clip.none,
                  scrollDirection: Axis.horizontal,
                  itemCount: chapter.stories.length,
                  itemBuilder: (context, index) {
                    return PracticeContainer(
                      story: chapter.stories[index],
                      text: chapter.stories[index].title,
                      icon: Icons.menu_book_rounded,
                      action: () {
                        Navigator.pushNamed(
                          context,
                          '/story',
                          arguments: chapter.stories[index],
                        ).then((_) {
                          chapter.updateProgess();
                        });
                      },
                      color: index % 2 == 0
                          ? AppColours.blue
                          : AppColours.blue2,
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Audio Lessons",
                style: TextStyle(color: AppColours.foreground2, fontSize: 18),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ListView.builder(
                  clipBehavior: Clip.none,
                  scrollDirection: Axis.horizontal,
                  itemCount: chapter.stories.length,
                  itemBuilder: (context, index) {
                    return PracticeContainer(
                      story: chapter.stories[index],
                      text: "Audio Lesson",
                      icon: Icons.mic,
                      action: () {
                        Navigator.pushNamed(
                          context,
                          '/story',
                          arguments: chapter.stories[index],
                        );
                      },
                      color: index % 2 == 0
                          ? AppColours.orange
                          : AppColours.orange2,
                    );
                  },
                ),
              ),
            ),
            Navbar(),
          ],
        ),
      ),
    );
  }
}
