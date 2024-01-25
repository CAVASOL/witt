import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:login_auth/pages/camera.dart';
import 'package:login_auth/pages/auth.dart';
import 'package:login_auth/pages/home.dart';
import 'package:login_auth/pages/register.dart';
import 'package:login_auth/pages/welcome.dart';
import 'package:login_auth/pages/search.dart';
import 'package:login_auth/pages/profile.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final Function()? onTap;

  const MyApp({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WITT',
      theme: ThemeData(fontFamily: 'NotoSansKR'),
      routes: {
        '/': (context) => const Welcome(),
        '/login': (context) => const Auth(),
        '/register': (context) => RegisterPage(onTap: onTap),
        '/home': (context) => Home(),
        '/profile': (context) => Profile(),
        '/search': (context) => Search(),
        '/camera': (context) => const PickImage(),
      },
    );
  }
}
