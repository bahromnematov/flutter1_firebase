import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter1_firebase/pages/create_page.dart';
import 'package:flutter1_firebase/pages/home_page.dart';
import 'package:flutter1_firebase/pages/signin_page.dart';
import 'package:flutter1_firebase/pages/signup_page.dart';
import 'package:flutter1_firebase/pages/splash_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding();
  runApp(const MyApp());
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashPage(),
      routes: {
        SplashPage.id: (context) => SplashPage(),
        SigninPage.id: (context) => SigninPage(),
        SignupPage.id: (context) => SignupPage(),
        HomePage.id: (context) => HomePage(),
        CreatePage.id: (context) => CreatePage(),
      },
    );
  }
}
