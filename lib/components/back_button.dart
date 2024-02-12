import 'package:flutter/material.dart';

class BackButton extends StatelessWidget {
  const BackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Container(
            padding: const EdgeInsets.all(
              4,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                style: BorderStyle.solid,
                color: Colors.grey.shade300,
              ),
              borderRadius: BorderRadius.circular(
                20,
              ),
            ),
            child: const Icon(
              Icons.arrow_back_rounded,
              color: Color(0xFF292929),
            ),
          ),
        ),
      ],
    );
  }
}
