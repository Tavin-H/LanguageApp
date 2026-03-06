import 'package:flash_fluent/screens/home_screen.dart';
import 'package:flash_fluent/screens/learn_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   const MyApp({super.key});

@override
Widget build(BuildContext context) {
  return MaterialApp(
	initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/learn': (context) => const LearnScreen(),
      },
  );
}
}
