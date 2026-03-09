import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Home"),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/learn');
              },
              child: Text("Learn"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/bookmarks');
              },
              child: Text("Bookmarks"),
            ),
          ],
        ),
      ),
    );
  }
}
