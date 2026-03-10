import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text("Home"),
            Expanded(child: Placeholder()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/learn');
                  },
                  child: Text("Learn"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/practice');
                  },
                  child: Text("Practice"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/bookmarks');
                  },
                  child: Text("Bookmarks"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
