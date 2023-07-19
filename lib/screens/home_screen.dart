import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:square_ghost/reusable_widget/constants.dart';
import 'package:square_ghost/screens/login_screen.dart';

import '../services/delete_account.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      elevation: 0,
      title: const Text(
        'Square Ghost',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
        actions: [
          const DeleteAccount(),
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) {
                  print('outttt');
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const LogInScreen()));
                });
              },
              icon: const Icon(Icons.logout_rounded))
        ],
      ),
      backgroundColor: myBackgroundColor,
      body: const Center(
        child: Text(
          'Home Page',
          style: TextStyle(fontSize: 29),
        ),
      ),
    );
  }
}
