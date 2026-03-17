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
            Center(
              child: StyledButton(
                text: "Flashcards",
                func: () {
                  Navigator.pushNamed(context, '/flashcard_hub');
                },
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
