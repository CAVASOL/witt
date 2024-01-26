import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_auth/widgets/widgets.dart';

class Search extends StatelessWidget {
  Search({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  void logOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LocationSearchBar(),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: SizedBox(
          height: 90,
          child: BottomAppBar(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 8,
                left: 12,
                right: 12,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Search
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/home',
                      );
                    },
                    child: const Column(
                      children: [
                        Icon(
                          Icons.home_outlined,
                          color: Color(0xFF292929),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          '홈',
                          style: TextStyle(
                            color: Color(0xFF292929),
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Favorite
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/search',
                      );
                    },
                    child: const Column(
                      children: [
                        Icon(
                          Icons.explore_outlined,
                          color: Color.fromARGB(255, 49, 27, 27),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          '검색',
                          style: TextStyle(
                            color: Color(0xFF292929),
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Airbnb
                  const Column(
                    children: [
                      Icon(
                        Icons.camera_rounded,
                        color: Color(0xFF292929),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        '카메라',
                        style: TextStyle(
                          color: Color(0xFF292929),
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  // Chat
                  const Column(
                    children: [
                      Icon(
                        Icons.cases_outlined,
                        color: Color(0xFF292929),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        '나의 페이지',
                        style: TextStyle(
                          color: Color(0xFF292929),
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  // Profile
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/profile',
                      );
                    },
                    child: const Column(
                      children: [
                        Icon(
                          Icons.person_outline_rounded,
                          color: Color(0xFF292929),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          '프로필',
                          style: TextStyle(
                            color: Color(0xFF292929),
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
