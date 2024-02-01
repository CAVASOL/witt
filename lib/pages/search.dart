import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_auth/widgets/widgets.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final user = FirebaseAuth.instance.currentUser!;
  int _currentIndex = 1;

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
                  buildNavItem(Icons.explore_outlined, 'Search', 1),
                  buildNavItem(Icons.camera_rounded, 'Camera', 2),
                  buildNavItem(Icons.cases_outlined, 'My Page', 3),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildNavItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () {
        // 아이콘을 탭했을 때의 동작을 정의합니다.
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
