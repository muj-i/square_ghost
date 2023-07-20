import 'package:flutter/material.dart';
import 'package:square_ghost/screens/login_screen.dart';
import 'package:square_ghost/screens/signup_screen.dart';

class SignedinCheckingScreen extends StatefulWidget {
  const SignedinCheckingScreen({super.key});

  @override
  State<SignedinCheckingScreen> createState() => _SignedinCheckingScreenState();
}

class _SignedinCheckingScreenState extends State<SignedinCheckingScreen> {
  // initially, show log in page
  bool showLoginPage = true;

  void toggleScreen(){
setState(() {
  showLoginPage = !showLoginPage;
});
  }
  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LogInScreen(showSignUpPage: toggleScreen);
    } else {
      return SignUpScreen(showLogInPage: toggleScreen);
    }
  }
}
