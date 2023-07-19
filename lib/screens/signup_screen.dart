import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:square_ghost/reusable_widget/elevated_button.dart';
import 'package:square_ghost/reusable_widget/text_field_widget.dart';
import 'package:square_ghost/screens/home_screen.dart';
import 'package:square_ghost/utils/color_utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Sign Up',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
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
            child: Column(children: <Widget>[
              const SizedBox(
                height: 30,
              ),
              reusableTextField('Enter User Name', Icons.person_2_rounded,
                  false, _userNameController),
              const SizedBox(
                height: 30,
              ),
              reusableTextField(
                  'Enter Email', Icons.lock_rounded, true, _emailController),
              const SizedBox(
                height: 30,
              ),
              reusableTextField('Enter Password', Icons.lock_rounded, true,
                  _passwordController),
              const SizedBox(
                height: 30,
              ),
              signInSignUpButton(context, false, () {
                FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                        email: _emailController.text,
                        password: _passwordController.text)
                    .then((value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                }).onError(
                  (error, stackTrace) {
                    print("E ${error.toString()}");
                  },
                );
              }),ElevatedButton(onPressed: (){
                FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                    email: _emailController.text,
                    password: _passwordController.text)
                    .then((value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                }).onError(
                        (error, stackTrace) {
                      print("E ${error.toString()}");
                    });

          }, child: Icon(Icons.login))

            ]),
          ),
        ),
      ),
    );
  }
}
