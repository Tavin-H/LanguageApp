import 'package:flash_fluent/flash_fluent.dart';
import 'package:flutter/material.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   const MyApp({super.key});

@override
Widget build(BuildContext context) {
  return MaterialApp(
    home: Scaffold(
      // Move SafeArea here so it protects the whole body
      body: Expanded(
        child: Center(
          child: SafeArea( 
            child: FlashFluent(),
          ),
        ),
      ),
    ),
  );
}
}
