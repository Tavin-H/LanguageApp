import 'package:flash_fluent/custom-widgets/navbar.dart';
import 'package:flutter/material.dart';

class PracticeScreen extends StatelessWidget {
  const PracticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: SizedBox.shrink()),

            Navbar(),
          ],
        ),
      ),
    );
  }
}
