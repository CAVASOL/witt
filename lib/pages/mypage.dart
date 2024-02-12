import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_auth/components/button.dart';
// import 'package:login_auth/services/assets_manager.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final user = FirebaseAuth.instance.currentUser!;

  int _currentIndex = 3;

  void logOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 240,
              ),
              // Center(
              //   child: Image.asset(
              //     AssetsManager.bye,
              //     width: 200,
              //     height: 200,
              //   ),
              // ),
              const Text(
                "감사합니다 \n곧 다시 만나요!",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 16,
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
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 90,
        child: BottomAppBar(
          color: const Color(0xFF45757B),
          shadowColor: Colors.grey.shade100,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 8,
              left: 12,
              right: 12,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildNavItem(Icons.home_outlined, 'Home', 0),
                buildNavItem(Icons.question_answer_rounded, 'Chat', 1),
                buildNavItem(Icons.camera_rounded, 'Camera', 2),
                buildNavItem(Icons.person_outline_rounded, 'My Page', 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildNavItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
        switch (_currentIndex) {
          case 0:
            Navigator.pushNamed(context, '/home');
            break;
          case 1:
            Navigator.pushNamed(context, '/search');
            break;
          case 2:
            Navigator.pushNamed(context, '/camera');
            break;
          case 3:
            Navigator.pushNamed(context, '/mypage');
            break;
        }
      },
      child: Column(
        children: [
          Icon(
            icon,
            color:
                _currentIndex == index ? Colors.white : const Color(0xFF292929),
            size: 28,
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            label,
            style: TextStyle(
              color: _currentIndex == index
                  ? Colors.white
                  : const Color(0xFF292929),
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
