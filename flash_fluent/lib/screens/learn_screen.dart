import 'package:flutter/material.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text("Learn"),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/vocab');
              },
              child: Text("Noun"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/grammar');
              },
              child: Text("Grammar"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/grammar_diff');
              },
              child: Text("Grammar Dif"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/vocab_diff');
              },
              child: Text("Noun Dif"),
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
