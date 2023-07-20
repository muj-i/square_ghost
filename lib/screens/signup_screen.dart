import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:square_ghost/reusable_widget/constants.dart';
import 'package:square_ghost/reusable_widget/sign_in_sign_up_button.dart';
import 'package:square_ghost/reusable_widget/text_field_widget.dart';

class SignUpScreen extends StatefulWidget {
  final VoidCallback showLogInPage;
  const SignUpScreen({super.key, required this.showLogInPage});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  //sign up method
  Future signUp() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim());
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                //logo image
                logoWidget('assets/logo/logo.png'),
                Text(
                  "Hello There",
                  style: myGFontTextStyle,
                ),
                //welcome messeage
                Text(
                  "Register below with your details",
                  style: myTextStyle,
                ),
                const SizedBox(
                  height: 30,
                ),
                //email textfiled
                ReusableTextField(
                  labelText: 'Enter User Name',
                  icon: Icons.person_rounded,
                  obscureText: false,
                  controller: _userNameController,
                ),
                const SizedBox(
                  height: 30,
                ),
                ReusableTextField(
                  labelText: 'Enter Email Address',
                  icon: Icons.email_rounded,
                  obscureText: false,
                  controller: _emailController,
                ),
                const SizedBox(
                  height: 30,
                ),
                ReusableTextField(
                  labelText: 'Enter Password',
                  icon: Icons.lock_rounded,
                  obscureText: true,
                  controller: _passwordController,
                ),
                const SizedBox(
                  height: 30,
                ),
                LogInSignUpButton(
                  isLogin: false,
                  onTap: () {
                    signUp();
                  },
                ),
                const SizedBox(height: 10,),
                signInOption(),
              ]),
        ),
      ),
    );
  }

//sign in option method
  Row signInOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Have an account?",
          style: myTextStyle,
        ),
        GestureDetector(
          onTap: () {
            widget.showLogInPage();
          
          },
          child: Text(
            " Log In",
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
