import 'package:flutter/material.dart';

class ThemeButton extends StatelessWidget {
  const ThemeButton({super.key, required this.color, required this.onTap});
  final Color? color;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 80,
            height: 40,
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(
                  20,
                )),
            padding: const EdgeInsets.all(
              24,
            ),
            child: const Center(
              child: Text(
                "tap",
              ),
            ),
          ),
        ),
      ],
    );
  }
}
