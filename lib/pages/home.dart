import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:login_auth/components/info_card.dart';
import 'package:login_auth/components/sample.dart';
import 'package:login_auth/components/theme_button.dart';
import 'package:login_auth/services/assets_manager.dart';
import 'package:login_auth/widgets/widgets.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  final user = FirebaseAuth.instance.currentUser!;
  int _selectedIndex = 0;

  void logOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 20,
                    bottom: 40,
                  ),
                  child: ThemeButton(
                    color: Colors.red,
                    onTap: () {},
                  ),
                ),
                const SafeArea(
                  child: Center(
                    child: KeySearchBar(),
                  ),
                ),
                const SizedBox(
                  height: 64,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 32,
                  ),
                  child: Column(
                    children: [
                      Text(
                        "WITT 하이라이트",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Sample(image: AssetsManager.busPicture),
                    Sample(image: AssetsManager.segSam)
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 32,
                  ),
                  child: Column(
                    children: [
                      Text(
                        "More WITT",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/translate',
                            );
                          },
                          child: const InfoCard(
                            text: "WITT 번역기",
                            bgColor: Colors.white,
                            textColor: Color(0xFF292929),
                            borderColor: Colors.grey,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/explore',
                            );
                          },
                          child: const InfoCard(
                            text: "사진 속에 \n무엇이 있을까?",
                            bgColor: Colors.white,
                            textColor: Color(0xFF292929),
                            borderColor: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    left: 32,
                    right: 32,
                  ),
                  child: Divider(),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 32,
                      ),
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Privacy",
                          style: TextStyle(
                            color: Color(0xFF292929),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 32,
                        right: 32,
                      ),
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Terms",
                          style: TextStyle(
                            color: Color(0xFF292929),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 32,
                      ),
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "About",
                          style: TextStyle(
                            color: Color(0xFF292929),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(
                        12,
                      ),
                      child: Image.asset(
                        AssetsManager.instaLogo,
                        width: 32,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(
                        12,
                      ),
                      child: Image.asset(
                        AssetsManager.pinterestLogo,
                        width: 32,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(
                        12,
                      ),
                      child: Image.asset(
                        AssetsManager.twitterLogo,
                        width: 32,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "© WITT, Inc. 2024. \nWe love our users!",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 80,
                )
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
                color: Colors.black.withOpacity(
                  .1,
                ),
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
