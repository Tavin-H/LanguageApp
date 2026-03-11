import 'package:flash_fluent/utils/app_consts.dart';
import 'package:flutter/material.dart';

class StyledButton extends StatelessWidget {
  const StyledButton({super.key, required this.text, required this.func});
  final String text;
  final void Function() func;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColours.orange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(10),
        ),
      ),

      onPressed: func,

      child: Text(text, style: TextStyle(color: AppColours.background2)),
    );
  }
}
