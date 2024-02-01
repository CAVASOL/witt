import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class InfoCard extends StatelessWidget {
  final String text;
  final Color bgColor;
  final Color textColor;
  final Color borderColor;

  const InfoCard({
    super.key,
    required this.text,
    required this.bgColor,
    required this.textColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(8),
        strokeWidth: 1.5,
        color: borderColor,
        child: Container(
          width: 140,
          height: 100,
          decoration: BoxDecoration(
            color: bgColor,
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
        ),
      ),
    );
  }
}
