import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:login_auth/components/button.dart';
import 'package:login_auth/services/assets_manager.dart';
// import 'package:login_auth/services/assets_manager.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final user = FirebaseAuth.instance.currentUser!;
  int _selectedIndex = 3;

  void logOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF45757B),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 100,
              ),
              Center(
                child: Image.asset(
                  AssetsManager.yar,
                  width: 320,
                  height: 320,
                ),
              ),
              Center(
                child: GestureDetector(
                  onTap: logOut,
                  child: const Button(
                    text: "WITT 나가기",
                    bgColor: Color(0xFF292929),
                    textColor: Colors.white,
                    borderColor: Color(0xFF292929),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          color: const Color(0xFF45757B),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 8,
            ),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 12,
              ),
              duration: const Duration(
                milliseconds: 400,
              ),
              tabBackgroundColor: Colors.white,
              color: Colors.black,
              tabs: const [
                GButton(
                  icon: Icons.home_rounded,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.question_answer_rounded,
                  text: 'Chat',
                ),
                GButton(
                  icon: Icons.camera_rounded,
                  text: 'Camera',
                ),
                GButton(
                  icon: Icons.person_outline_rounded,
                  text: 'My Page',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
                navigateTo(index);
              },
            ),
          ),
        ),
      ),
    );
  }

  void navigateTo(int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home').then((value) => {
              setState(() {
                _selectedIndex = value as int;
              })
            });
        break;
      case 1:
        Navigator.pushNamed(context, '/search').then((value) => {
              setState(() {
                _selectedIndex = value as int;
              })
            });
        break;
      case 2:
        Navigator.pushNamed(context, '/camera').then((value) => {
              setState(() {
                _selectedIndex = value as int;
              })
            });
        break;
      case 3:
        Navigator.pushNamed(context, '/mypage').then((value) => {
              setState(() {
                _selectedIndex = value as int;
              })
            });
        break;
    }
  }
}
