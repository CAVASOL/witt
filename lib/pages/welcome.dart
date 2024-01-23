import 'package:flutter/material.dart';

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
              height: 240,
            ),
            Center(
              child: Image.asset(
                'images/sam18.png',
                width: 200,
                height: 200,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              style: const ButtonStyle(
                alignment: Alignment.center,
              ),
              child: const Text(
                "로그인",
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              style: const ButtonStyle(
                alignment: Alignment.center,
              ),
              child: const Text(
                "WITT 가입하기",
              ),
            ),
            const SizedBox(
              height: 64,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Countinue as',
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                const Text(
                  'a Guest',
                  style: TextStyle(
                    color: Color(0xFF45757B),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
