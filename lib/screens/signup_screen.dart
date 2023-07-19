import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:square_ghost/reusable_widget/constants.dart';
import 'package:square_ghost/reusable_widget/elevated_button.dart';
import 'package:square_ghost/reusable_widget/text_field_widget.dart';
import 'package:square_ghost/screens/home_screen.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const MyAppBar(appBarTitle: 'Sign Up'
        
      ),
      backgroundColor: myBackgroundColor,
      body: SingleChildScrollView(
        
        child: Padding(
          
          padding: const EdgeInsets.symmetric(
              vertical: 75),
          child: Column(children: <Widget>[
            // const SizedBox(
            //   height: 15,
            // ),
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
            SignInSignUpButton(
              isLogin: false,
              onTap: () {
                FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                        email: _emailController.text,
                        password: _passwordController.text)
                    .then((value) {
                  
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                }).onError((error, stackTrace) {
                  print("Error ${error.toString()}");
                });
              },
            ),
          ]),
        ),
      ),
    );
  }
}
