import 'package:flutter/material.dart';
import 'package:square_ghost/pages/login_page.dart';
import 'package:square_ghost/pages/signup_page.dart';

class SignedinCheckingPage extends StatefulWidget {
  const SignedinCheckingPage({super.key});

  @override
  State<SignedinCheckingPage> createState() => _SignedinCheckingPageState();
}

class _SignedinCheckingPageState extends State<SignedinCheckingPage> {
  // initially, show log in page
  bool showLoginPage = true;

  void togglePage(){
setState(() {
  showLoginPage = !showLoginPage;
});
  }
  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LogInPage(showSignUpPage: togglePage);
    } else {
      return SignUpPage(showLogInPage: togglePage);
    }
  }
}
