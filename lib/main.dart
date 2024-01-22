import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:login_auth/pages/auth.dart';
import 'package:login_auth/pages/login_page.dart';
import 'package:login_auth/pages/register.dart';
import 'package:login_auth/pages/welcome.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Welcome(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const Register(),
        '/auth': (context) => const Auth(),
      },
    );
  }
}
