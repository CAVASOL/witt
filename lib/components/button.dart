import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final Color bgColor;
  final Color textColor;
  final Color borderColor;

  const Button(
      {super.key,
      required this.text,
      required this.bgColor,
      required this.textColor,
      required this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 56,
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(
          style: BorderStyle.solid,
          color: borderColor,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 10,
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
