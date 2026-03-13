import 'package:flash_fluent/custom-widgets/navbar.dart';
import 'package:flash_fluent/custom-widgets/styled_button.dart';
import 'package:flash_fluent/utils/app_consts.dart';
import 'package:flash_fluent/utils/json_utils.dart';
import 'package:flutter/material.dart';

class PracticeContainer extends StatelessWidget {
  const PracticeContainer({
    super.key,
    required this.text,
    required this.icon,
    required this.action,
    required this.color,
  });
  final void Function() action;
  final String text;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
      child: Column(
        children: [
          InkWell(
            onTap: action,
            child: SizedBox(
              height: 80,
              width: 100,
                child: Container(
								decoration: BoxDecoration(border: Border.all(color: color, width: 3), borderRadius:  BorderRadius.circular(12)),
                  child: Center(
                    child: Icon(icon, size: 40, color: AppColours.foreground),
                  ),
                ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            text,
            style: TextStyle(color: AppColours.foreground, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class PracticeScreen extends StatelessWidget {
  const PracticeScreen({super.key, required this.stories});

  final List<Story> stories;

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
                  scrollDirection: Axis.horizontal,
                  itemCount: stories.length,
                  itemBuilder: (context, index) {
                    return PracticeContainer(
                      text: stories[index].title,
                      icon: Icons.menu_book_rounded,
                      action: () {
                        Navigator.pushNamed(
                          context,
                          '/story',
                          arguments: stories[index],
                        );
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
                  scrollDirection: Axis.horizontal,
                  itemCount: stories.length,
                  itemBuilder: (context, index) {
                    return PracticeContainer(
                      text: "Audio Lesson",
                      icon: Icons.mic,
                      action: () {
                        Navigator.pushNamed(
                          context,
                          '/story',
                          arguments: stories[index],
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
