import 'package:flutter/material.dart';
import 'package:login_auth/components/button.dart';
import 'package:login_auth/services/assets_manager.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF45757B),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 320,
            ),
            Center(
              child: Image.asset(
                AssetsManager.wittLogoDark,
                width: 200,
                height: 200,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/login',
                );
              },
              child: const Button(
                text: "들어가기",
                bgColor: Color(0xFF292929),
                textColor: Colors.white,
                borderColor: Color(0xFF292929),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/login',
                );
              },
              child: const Button(
                text: "WITT 가입하기",
                bgColor: Colors.white,
                textColor: Color(0xFF292929),
                borderColor: Colors.white,
              ),
            ),
            const SizedBox(
              height: 64,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '손님으로',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  '입장하기',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 80,
            )
          ],
        ),
      ),
    );
  }
}
