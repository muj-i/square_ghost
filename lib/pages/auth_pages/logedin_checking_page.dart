import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:square_ghost/pages/auth_pages/signedup_checking_page.dart';
import 'package:square_ghost/pages/home_page.dart';



class LogedinCheckingPage extends StatelessWidget {
  const LogedinCheckingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomePage();
          } else {
            return const SignedinCheckingPage();
          }
        },
      ),);
  }
}