import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:square_ghost/reusable_widgets/constants.dart';
import 'package:square_ghost/reusable_widgets/log_in_sign_up_button.dart';
import 'package:square_ghost/reusable_widgets/text_field_widget.dart';


class SignUpPage extends StatefulWidget {
  final VoidCallback showLogInPage;
  const SignUpPage({super.key, required this.showLogInPage});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _userNameController = TextEditingController();

//dispose for memory management
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _userNameController.dispose();

    super.dispose();
  }
/////////////
  //sign up method
  Future signUp() async {
    try {
      if (passwordConfirmed()) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim());
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      ErrorDialog(errorMessage: e.message.toString()).showAlertDialog(context);
    }
  }

//pass confirm method
  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
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
                  height: 20,
                ),
                //email textfiled

                ReusableTextField(
                  labelText: 'Enter Email Address',
                  icon: Icons.email_rounded,
                  obscureText: false,
                  controller: _emailController,
                ),
                const SizedBox(
                  height: 20,
                ),
                ReusableTextField(
                  labelText: 'Enter Password',
                  icon: Icons.lock_rounded,
                  obscureText: true,
                  controller: _passwordController,
                ),
                const SizedBox(
                  height: 20,
                ),
                ReusableTextField(
                  labelText: 'Confirm Password',
                  icon: Icons.lock_rounded,
                  obscureText: true,
                  controller: _confirmPasswordController,
                ),
                const SizedBox(
                  height: 20,
                ),
                ReusableTextField(
                  labelText: 'Enter Your Name',
                  icon: Icons.person_rounded,
                  obscureText: false,
                  controller: _userNameController,
                ),
                const SizedBox(
                  height: 20,
                ),
                LogInSignUpButton(
                  isLogin: false,
                  onTap: () {
                    signUp();
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
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
            style: myGestureTextStyle,
          ),
        )
      ],
    );
  }
}
