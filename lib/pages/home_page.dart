import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:square_ghost/pages/user_data_page.dart';
import 'package:square_ghost/reusable_widgets/constants.dart';

import '../services/delete_account.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

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
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Icons.logout_rounded))
        ],
      ),
      backgroundColor: myBackgroundColor,
      body: Column(
        children: [
          Center(
            child: Text(
              'Signed in as: ${user.email!}',
              style: const TextStyle(fontSize: 29),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return UserDataInputPage();
                }));
              },
              child: Text('data'))
        ],
      ),
    );
  }
}
