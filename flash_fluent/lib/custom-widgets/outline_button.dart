import 'package:flash_fluent/utils/app_consts.dart';
import 'package:flutter/material.dart';

class OutlineButton extends StatelessWidget {
  const OutlineButton({super.key, required this.text});
	final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(width: 3, color: AppColours.orange),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Center(child: Text(text)),
      ),
    );
  }
}
