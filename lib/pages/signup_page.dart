import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter1_firebase/pages/home_page.dart';
import 'package:flutter1_firebase/pages/signin_page.dart';
import 'package:flutter1_firebase/servise/auth_servise.dart';


class SignupPage extends StatefulWidget {
  static final String id="signup_page";
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var cpasswordController=TextEditingController();

  _doSignUp(){
    var name=nameController.text.toString().trim();
    var email=emailController.text.toString().trim();
    var password=passwordController.text.toString().trim();
    var cpassword=cpasswordController.text.toString().trim();

    if(name.isEmpty||email.isEmpty||password.isEmpty||cpassword.isEmpty) return;

   AuthService.signUpUser(email, password, name, cpassword).then((value) => {
     responseSignUp(value!),
   });
  }

  void responseSignUp(User firebaseUser){
    Navigator.pushReplacementNamed(context, HomePage.id);
  }


  callNextSignIn(){
    Navigator.pushReplacementNamed(context, SigninPage.id);
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
                ]
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //name
            Container(
              height: 50,
              padding: EdgeInsets.only(left: 10,right: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Colors.white54.withOpacity(0.2)
              ),
              child: TextField(
                controller: nameController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    hintText: "Name",
                    hintStyle: TextStyle(color: Colors.white54,fontSize: 17),
                    border: InputBorder.none
                ),
              ),
            ),

            SizedBox(height: 12,),
            //email
            Container(
              height: 50,
              padding: EdgeInsets.only(left: 10,right: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Colors.white54.withOpacity(0.2)
              ),
              child: TextField(
                controller: emailController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    hintText: "Email",
                    hintStyle: TextStyle(color: Colors.white54,fontSize: 17),
                    border: InputBorder.none
                ),
              ),
            ),

            SizedBox(height: 12,),

            //password
            Container(
              height: 50,
              padding: EdgeInsets.only(left: 10,right: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Colors.white54.withOpacity(0.2)
              ),
              child: TextField(
                controller: passwordController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: TextStyle(color: Colors.white54,fontSize: 17),
                    border: InputBorder.none
                ),
              ),
            ),

            SizedBox(height: 12,),

            //confirmpassword
            Container(
              height: 50,
              padding: EdgeInsets.only(left: 10,right: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Colors.white54.withOpacity(0.2)
              ),
              child: TextField(
                controller: cpasswordController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    hintText: "ConfirmPassword",
                    hintStyle: TextStyle(color: Colors.white54,fontSize: 17),
                    border: InputBorder.none
                ),
              ),
            ),

            SizedBox(height: 12,),
            InkWell(
              onTap: _doSignUp,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.white54.withOpacity(0.2)
                ),
                child: Center(
                  child: Text("Sign Up",style: TextStyle(color: Colors.white70,fontSize: 17,fontWeight: FontWeight.bold),),
                ),
              ),
            ),

            SizedBox(height: 12,),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("All ready have a account",style: TextStyle(color: Colors.white54),),
                TextButton(onPressed: (){
                  callNextSignIn();
                }, child: Text("Sign In",style: TextStyle(color: Colors.white70,fontWeight: FontWeight.bold,fontSize: 16),))
              ],
            )
          ],
        ),
      ),
    );
  }
}
