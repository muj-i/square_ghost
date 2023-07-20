import 'package:flutter/material.dart';
import 'package:square_ghost/reusable_widget/elevated_button.dart';

import 'package:square_ghost/reusable_widget/text_field_widget.dart';
import 'package:square_ghost/screens/home_screen.dart';
import 'package:square_ghost/screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../reusable_widget/constants.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
 final GlobalKey<FormState> _emailFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _passwordFormKey = GlobalKey<FormState>();


  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 30,
              ),
              logoWidget('assets/logo/logo.png'),
              Text(
                "Wlcome back, you've been missed!",
                style: myTextStyle,
              ),
              const SizedBox(
                height: 30,
              ),
              ReusableTextField(
                labelText: 'Enter Email Address',
                icon: Icons.email_rounded,
                obscureText: false,
                controller: _emailController, formValidationKey: _emailFormKey, validator: (String? value ) { if (value == null || value.isEmpty){return 'Please enter an email address.';}
 return null;},
              ),
              const SizedBox(
                height: 20,
              ),
              ReusableTextField(
                labelText: 'Enter Password',
                icon: Icons.lock_rounded,
                obscureText: true,
                controller: _passwordController, formValidationKey: _passwordFormKey, validator: (String? value ) { if (value == null || value.isEmpty){return 'Please enter Password.';}
 return null;},
              ),
              const SizedBox(
                height: 10,
              ),
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: myTextStyle,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SignInSignUpButton(
                isLogin: true,
                onTap: () {
                 
                  FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text)
        .then((value) {
      Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(builder: (context) => const HomeScreen())
          ,(route) => false,);
    });
                },
              ),
              const SizedBox(
                height: 10,
              ),
              signUpOption()
            ],
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
          style: myTextStyle,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignUpScreen()));
          },
          child: Text(
            " Sign Up",
            style: TextStyle(
                color: Colors.grey.shade800,
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
