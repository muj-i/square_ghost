import 'package:flutter/material.dart';
import 'package:square_ghost/reusable_widget/elevated_button.dart';
import 'package:square_ghost/reusable_widget/logo_widget.dart';
import 'package:square_ghost/reusable_widget/text_field_widget.dart';
import 'package:square_ghost/screens/home_screen.dart';
import 'package:square_ghost/screens/signup_screen.dart';
import 'package:square_ghost/utils/color_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';



class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            hexStringToColor('E5B93D'),
            hexStringToColor('FF1C30'),
            hexStringToColor('D1008C'),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                logoWidget('assets/logo/logo.png'),
                SizedBox(
                  height: 30,
                ),
                reusableTextField('Enter UserName', Icons.person_2_rounded,
                    false, _emailController),
                SizedBox(
                  height: 30,
                ),
                reusableTextField('Enter Password', Icons.lock_rounded, true,
                    _passwordController),
                SizedBox(
                  height: 30,
                ),
                signInSignUpButton(context, true, () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                }),
                signUpOption()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have account?",
          style: TextStyle(color: Colors.white70),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: Text(
            " Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
