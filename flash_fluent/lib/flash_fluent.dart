import 'package:flash_fluent/screens/home_screen.dart';
import 'package:flutter/material.dart';

class FlashFluent extends StatefulWidget {
  const FlashFluent({super.key});

  @override
  State<FlashFluent> createState() => _FlashFluentState();
}

class _FlashFluentState extends State<FlashFluent> {
  @override
  Widget build(BuildContext context) {
    return Container(
			child: HomeScreen(),
		);
  }
}

