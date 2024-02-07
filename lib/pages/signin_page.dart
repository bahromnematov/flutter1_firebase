import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter1_firebase/pages/home_page.dart';
import 'package:flutter1_firebase/pages/signup_page.dart';

import '../servise/auth_servise.dart';

class SigninPage extends StatefulWidget {
  static final String id = "signin_page";

  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  callNextSignUp() {
    Navigator.pushReplacementNamed(context, SignupPage.id);
  }

  _doSignIn() {
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();

    if (email.isEmpty || password.isEmpty) return;

    AuthService.signInUser(email, password).then((value) => {
          responseSignIn(value!),
        });
  }

  void responseSignIn(User firebaseUser) {
    Navigator.pushReplacementNamed(context, HomePage.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Color.fromRGBO(193, 53, 132, 1),
              Color.fromRGBO(131, 58, 180, 1),
            ])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //email
            Container(
              height: 50,
              padding: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Colors.white54.withOpacity(0.2)),
              child: TextField(
                controller: emailController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    hintText: "Email",
                    hintStyle: TextStyle(color: Colors.white54, fontSize: 17),
                    border: InputBorder.none),
              ),
            ),

            SizedBox(
              height: 12,
            ),

            //password
            Container(
              height: 50,
              padding: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Colors.white54.withOpacity(0.2)),
              child: TextField(
                controller: passwordController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: TextStyle(color: Colors.white54, fontSize: 17),
                    border: InputBorder.none),
              ),
            ),

            SizedBox(
              height: 12,
            ),
            InkWell(
              onTap: _doSignIn,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.white54.withOpacity(0.2)),
                child: Center(
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 12,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "All ready have a account",
                  style: TextStyle(color: Colors.white54),
                ),
                TextButton(
                    onPressed: () {
                      callNextSignUp();
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
