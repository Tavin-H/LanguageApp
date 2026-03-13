import 'package:flash_fluent/custom-widgets/navbar.dart';
import 'package:flash_fluent/custom-widgets/styled_button.dart';
import 'package:flash_fluent/utils/app_consts.dart';
import 'package:flutter/material.dart';

class IconStat extends StatelessWidget {
  const IconStat({super.key, required this.icon, required this.progress});
  final IconData icon;
  final int progress;
	void _showHint() {
    showModalBottomSheet(
      context: context,
      barrierColor: Colors.transparent,
      // makes the top corners rounded
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Container(
          height: 220,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColours.background2,
            borderRadius: BorderRadius.circular(25),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Whoops...",
                style: TextStyle(
                  color: AppColours.orange,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Heres a hint:",
                style: TextStyle(color: AppColours.foreground, fontSize: 18),
              ),
              Text(
                "\"${widget.questionObject.relaventLine}\"",
                style: TextStyle(
                  color: AppColours.foreground,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: StyledButton(
                  text: "Try again",
                  func: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 30, color: AppColours.foreground),
        SizedBox(width: 10),
        Text(
          "$progress",
          style: TextStyle(
            color: AppColours.foreground,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final sidePadding = 20.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: sidePadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.translate, color: AppColours.foreground),
                  ),
                  Text(
                    "Home",
                    style: TextStyle(
                      fontSize: 28,
                      color: AppColours.foreground,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.settings, color: AppColours.foreground),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: sidePadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //Stats of the course
                      SizedBox(
                        height: 40,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset("assets/images/korean_flag.png"),
                        ),
                      ),
                      IconStat(
                        icon: Icons.school_rounded,
                        progress: 16,
                      ), // Lessons
                      IconStat(
                        icon: Icons.menu_book_rounded,
                        progress: 8,
                      ), // Stories
                      IconStat(icon: Icons.mic, progress: 2),
                    ],
                  ),
                  SizedBox(height: 20),

                  Text(
                    "Chapter 1:",
                    style: TextStyle(
                      color: AppColours.foreground,
                      fontSize: 20,
                    ),
                  ),
                  LinearProgressIndicator(
                    value: 0.4,
                    minHeight: 6,
                    backgroundColor: AppColours.background2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColours.orange,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ],
              ),
            ),
            Expanded(child: Text("")),

            Navbar(),
          ],
        ),
      ),
    );
  }
}
