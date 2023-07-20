import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:square_ghost/reusable_widgets/constants.dart';
import 'package:square_ghost/reusable_widgets/fab.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  void _deleteAccount(BuildContext context) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.delete();
        
      }
    } catch (e) {
      
      // ignore: avoid_print
      print('Error deleting account: $e');
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'Square Ghost',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          actions: [
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'log_out') {
                  FirebaseAuth.instance.signOut();
                } else if (value == 'delete_account') {
                  
                  _deleteAccount;
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem<String>(
                    value: 'log_out',
                    child: Text('Log Out'),
                  ),
                  PopupMenuItem<String>(
                    value: 'delete_account',
                    child: Text('Delete Account'),
                  ),
                ];
              },
            ),
          ]),
      backgroundColor: myBackgroundColor,
      body: Column(
        children: [
          Center(
            child: Text(
              'Signed in as: ${user.email!}',
              style: const TextStyle(fontSize: 29),
            ),
          ),
          
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FabButton(
              onPressed: () {},
              icon: Icon(
                FontAwesomeIcons.solidPenToSquare,
                color: Colors.white,
              )),
        ],
      ),
    );
  }
}
