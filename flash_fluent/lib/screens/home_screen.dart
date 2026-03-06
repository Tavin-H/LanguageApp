import 'package:flash_fluent/utils/app_actions.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.actions});

	final AppActions? actions;

  @override
  Widget build(BuildContext context) {
    return Column(
		mainAxisAlignment: MainAxisAlignment.start,
		children: [Text("Home"),
		ElevatedButton(onPressed: (){
		print("Go to learn");
		}, child: Text("Learn"))]

		);
  }
}
