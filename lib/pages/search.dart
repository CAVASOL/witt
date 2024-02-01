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
                child: Center(
                  child: KeySearchBar(),
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
                          'Home',
                          style: TextStyle(
                            color: Color(0xFF292929),
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
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
                          color: Color(0xFF292929),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          'Search',
                          style: TextStyle(
                            color: Color(0xFF292929),
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/camera',
                      );
                    },
                    child: const Column(
                      children: [
                        Icon(
                          Icons.camera_rounded,
                          color: Color(0xFF292929),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Camera',
                          style: TextStyle(
                            color: Color(0xFF292929),
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/mypage',
                      );
                    },
                    child: const Column(
                      children: [
                        Icon(
                          Icons.cases_outlined,
                          color: Color(0xFF292929),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          'My Page',
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
