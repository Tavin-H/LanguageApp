import 'package:flash_fluent/utils/app_consts.dart';
import 'package:flutter/material.dart';

class OutlineButton extends StatelessWidget {
  const OutlineButton({super.key, required this.text, required this.onpressed});
  final String text;
  final Function() onpressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpressed,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(width: 3, color: AppColours.orange),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Center(child: Text(text)),
        ),
      ),
    );
  }
}
