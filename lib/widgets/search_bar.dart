import 'package:flutter/material.dart';
import 'package:login_auth/services/assets_manager.dart';

class KeySearchBar extends StatelessWidget {
  const KeySearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey.withOpacity(0.5),
          //     spreadRadius: 2,
          //     blurRadius: 4,
          //     offset: const Offset(0, 3),
          //   ),
          // ],
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: Colors.grey, width: 0.2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              children: [
                Icon(Icons.search),
                SizedBox(width: 8),
                Column(
                  children: [
                    SizedBox(
                      width: 200,
                      child: TextField(
                        maxLines: 1,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '키워드를 검색해 주세요.',
                          hintStyle: TextStyle(
                            color: Color(0xFF292929),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(width: 28),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.asset(
                AssetsManager.filterImg,
                height: 20,
                width: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
