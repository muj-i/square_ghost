import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:square_ghost/auth/signedup_checking_screen.dart';
import 'package:square_ghost/screens/home_screen.dart';



class LogedinCheckingScreen extends StatelessWidget {
  const LogedinCheckingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomeScreen();
          } else {
            return const SignedinCheckingScreen();
          }
        },
      ),);
  }
}