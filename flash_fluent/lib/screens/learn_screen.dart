import 'package:flash_fluent/utils/app_actions.dart';
import 'package:flutter/material.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key, required this.actions });
	final AppActions? actions;

  @override
  Widget build(BuildContext context) {
    return Column( children: [Text("Learn")],);
  }
}
