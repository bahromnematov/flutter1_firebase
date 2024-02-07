import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter1_firebase/pages/home_page.dart';
import 'package:flutter1_firebase/pages/signin_page.dart';

import '../servise/auth_servise.dart';

class SplashPage extends StatefulWidget {
  static final String id = "splash_page";

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initTimer();
  }

  void initTimer() {
    Timer(Duration(seconds: 3), () {
      callNextPage();
    });
  }

  callNextPage() {
    if(AuthService.isLoggedIn()){
      Navigator.pushReplacementNamed(context, HomePage.id);
    }else{
      Navigator.pushReplacementNamed(context, SigninPage.id);
    }
    // Navigator.pushReplacementNamed(context, SigninPage.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors:[
              Color.fromRGBO(193, 53, 132, 1),
              Color.fromRGBO(131, 58, 180, 1),
            ]
          )
        ),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Center(
                child: Text("Welcome to Firebase",style: TextStyle(fontSize: 35,color: Colors.white,fontWeight: FontWeight.w500),),
              ),
            ),
            Text("All rights reversed",style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w500),),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}
