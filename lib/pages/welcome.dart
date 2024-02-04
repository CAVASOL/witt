import 'package:flutter/material.dart';
import 'package:login_auth/components/button.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF7DC7BF),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 320,
            ),
            Center(
              child: Image.asset(
                'assets/images/sam18.png',
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
                text: "Login",
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
                  'Countinue as',
                  style: TextStyle(
                    color: Color(0xFF292929),
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  'a Guest',
                  style: TextStyle(
                    color: Color(0xFF292929),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
