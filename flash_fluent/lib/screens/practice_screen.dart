import 'package:flash_fluent/custom-widgets/navbar.dart';
import 'package:flash_fluent/custom-widgets/styled_button.dart';
import 'package:flash_fluent/utils/app_consts.dart';
import 'package:flutter/material.dart';

class PracticeScreen extends StatelessWidget {
  const PracticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
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
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColours.background2,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 20),
                        Text(
                          "K-E Dictionary",
                          style: TextStyle(
                            color: AppColours.foreground,
                            fontSize: 16,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.book, color: AppColours.orange),
                        ),
                        Expanded(child: Container()),
                        Text(
                          "K-K Dictionary",
                          style: TextStyle(
                            color: AppColours.foreground,
                            fontSize: 16,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.book, color: AppColours.orange),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: StyledButton(
                      text: "Flashcards",
                      func: () {
                        Navigator.pushNamed(context, '/flashcard_hub');
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: SizedBox.shrink()),

            Navbar(),
          ],
        ),
      ),
    );
  }
}
