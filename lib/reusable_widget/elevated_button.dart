import 'package:flutter/material.dart';

class SignInSignUpButton extends StatelessWidget {
  final Function() onTap;
  final bool isLogin;

  const SignInSignUpButton(
      {super.key, required this.onTap, required this.isLogin});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
           padding: const EdgeInsets.symmetric(horizontal: 152,vertical: 15),
           margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
          ),
           child: Text(
             isLogin ? 'LOG IN' : 'SIGN UP',
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18),
           )
          ),
    );
  }
}



// FirebaseAuth.instance
//                     .signInWithEmailAndPassword(
//                         email: _emailController.text,
//                         password: _passwordController.text)
//                     .then((value) {
//                   print('in');
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => HomeScreen()));
//                 });