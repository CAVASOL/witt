import 'package:flutter/material.dart';

class Sample extends StatelessWidget {
  final String image;

  const Sample({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            width: 160,
            height: 200,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  offset: const Offset(2, 0),
                  color: Colors.black.withOpacity(0.2),
                )
              ],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Image.asset(
              image,
            ),
          ),
        ),
      ],
    );
  }
}
