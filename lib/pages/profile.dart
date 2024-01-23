import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  void logOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Profile",
              ),
              Center(
                child: IconButton(
                  onPressed: logOut,
                  icon: const Icon(
                    Icons.logout_rounded,
                  ),
                ),
              )
            ],
          ),
        ),
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
                const Column(
                  children: [
                    Icon(
                      Icons.explore_outlined,
                      color: Color(0xFF292929),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      '더 보기',
                      style: TextStyle(
                        color: Color(0xFF292929),
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                  ],
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
    );
  }
}
