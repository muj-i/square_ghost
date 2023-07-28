import 'package:flutter/material.dart';
import 'package:square_ghost/pages/auth_pages/forgot_password_page.dart';
import 'package:square_ghost/pages/auth_pages/signup_page.dart';
import 'package:square_ghost/reusable_widgets/log_in_sign_up_button.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../../reusable_widgets/constants.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({
    super.key,
  });

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
// textfield controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // ignore: unused_field
  bool _isLogingIn = false;

//sign in method
  Future logIn() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLogingIn = true;
      });

      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text);
      } on FirebaseAuthException catch (e) {
        ErrorDialog(errorMessage: e.message.toString())
            .showAlertDialog(context);
      } finally {
        setState(() {
          _isLogingIn = false;
        });
      }
    }
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: 'Enter Email Address',
                      prefixIcon: Icon(Icons.email_rounded),
                      prefixIconConstraints: BoxConstraints(
                        minWidth: 65,
                      ),
                    ),
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please fill out this field';
                      }
                      return null;
                    },
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
                //password textfiled

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextFormField(
                    controller: _passwordController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Enter Password',
                      prefixIcon: Icon(Icons.lock_rounded),
                      prefixIconConstraints: BoxConstraints(
                        minWidth: 65,
                      ),
                    ),
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please fill out this field';
                      }
                      return null;
                    },
                  ),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const ForgotPasswordPage();
                              },
                            ),
                          );
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
                Visibility(
                  visible: _isLogingIn == false,
                  replacement: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                  child: LogInSignUpButton(
                    isLogin: true,
                    onTap: () {
                      logIn();
                    },
                  ),
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
