import 'package:flutter/material.dart';

class LocationSearchBar extends StatelessWidget {
  const LocationSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey.withOpacity(0.5),
          //     spreadRadius: 2,
          //     blurRadius: 4,
          //     offset: const Offset(0, 3),
          //   ),
          // ],
          borderRadius: BorderRadius.circular(40),
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
                      width: 220,
                      child: TextField(
                        maxLines: 1,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '키워드를 검색해주세요!',
                          hintStyle: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    // Text(
                    //   'Wherever & Whenever',
                    //   style: TextStyle(
                    //     color: Colors.grey,
                    //     fontSize: 10,
                    //   ),
                    // ),
                  ],
                )
              ],
            ),
            const SizedBox(width: 24),
            Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.asset(
                'images/sam18.png',
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