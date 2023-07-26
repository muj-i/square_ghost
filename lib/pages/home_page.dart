

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:square_ghost/pages/update_user_data_page.dart';

import 'package:square_ghost/reusable_widgets/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  Map<String, dynamic>? userData;

 @override
  void initState() {
    super.initState();
   
    _fetchUserData();
  }

void _fetchUserData() {
    String userId = user.uid;
    DatabaseReference userRef =
        FirebaseDatabase.instance.ref().child('users').child(userId);

    userRef.onValue.listen((event) {
    // Handle the data when it is received
    if (event.snapshot.value != null) {
      setState(() {
        userData = Map<String, dynamic>.from(event.snapshot.value as Map<dynamic, dynamic>);
      });
    }
  }, onError: (Object? error) {
    // Handle any errors that occur during data retrieval
    print('Error fetching user data: $error');
  });
  }


  
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
                  setState(() {

                  });
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
          if (userData != null) // Check if user data is available
            Center(
              child: Column(
                children: [
                  Text('Name: ${userData!['name']}'),
                  Text('Age: ${userData!['age']}'),
                  Text('Bio: ${userData!['bio']}'),
                  Text('Gender: ${userData!['gender']}'),
                  // Add other user details as needed
                ],
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UpdateUserDataInputPage()));

          },
          child: Icon(
            FontAwesomeIcons.solidPenToSquare,
            color: Colors.white,
          )),
    );
  }
}