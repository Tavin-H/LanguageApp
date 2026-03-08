import 'package:flash_fluent/utils/json_utils.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.lessons});

  final List<Lesson> lessons;

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
          ],
        ),
      ),
    );
  }
}
