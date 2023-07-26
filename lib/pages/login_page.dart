import 'package:flutter/material.dart';
import 'package:square_ghost/pages/auth_pages/forgot_password_page.dart';
import 'package:square_ghost/pages/signup_page.dart';
import 'package:square_ghost/reusable_widgets/log_in_sign_up_button.dart';

import 'package:square_ghost/reusable_widgets/text_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../reusable_widgets/constants.dart';

class LogInPage extends StatefulWidget {
  
  const LogInPage({super.key,});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
// textfield controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//sign in method
  Future signIn() async {
    //try{
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim());
    //     } on FirebaseAuthException catch (e) {
    //  // ErrorDialog(errorMessage: e.message.toString()).showAlertDialog(context);
    // }
  }

  //dispose for memory management
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 30,
                ),
                //logo image
                logoWidget('assets/logo/logo.png'),
                //welcome messeage
                Text(
                  "Wlcome back, you've been missed!",
                  style: myGFontTextStyle,
                ),
                const SizedBox(
                  height: 30,
                ),
                //email textfiled
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Enter Email Address',

                  ),
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter your email';
                    }
                    return null;
                  },
                ),
                // TextFormField(
                //   labelText: 'Enter Email Address',
                //   icon: Icons.email_rounded,
                //   obscureText: false,
                //   controller: _emailController,
                //   TextInputType: TextInputType.emailAddress, TextInputAction: TextInputAction.next,
                // ),
                const SizedBox(
                  height: 20,
                ),
                //password textfiled
                ReusableTextField(
                  labelText: 'Enter Password',
                  icon: Icons.lock_rounded,
                  obscureText: true,
                  controller: _passwordController,
                  keyboardType: TextInputType.text, keyboardAction: TextInputAction.done,
                ),
                const SizedBox(
                  height: 10,
                ),
                //forgot password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ForgotPasswordPage();
                          },),);
                        },
                        child: Text(
                          'Forgot Password?',
                          style: myGestureTextStyle,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                //sign in button
                LogInSignUpButton(
                  isLogin: true,
                  onTap: () {
                    signIn();
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                //sign up option
                signUpOption()
              ],
            ),
          ),
        ),
      ),
    );
  }

//sign up option method
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
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const SignUpPage()),
                (route) => false);
          },
          child: Text(
            " Sign Up",
            style: myGestureTextStyle,
          ),
        )
      ],
    );
  }
}
