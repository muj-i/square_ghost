import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:square_ghost/pages/auth_pages/login_page.dart';

import 'package:square_ghost/pages/update_user_data_page.dart';
import 'package:square_ghost/reusable_widgets/all_over_button.dart';

import 'package:square_ghost/reusable_widgets/constants.dart';
import 'package:square_ghost/reusable_widgets/delete_account.dart';

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
          userData = Map<String, dynamic>.from(
              event.snapshot.value as Map<dynamic, dynamic>);
        });
      }
    }, onError: (Object? error) {
      ErrorDialog(errorMessage: error.toString()).showAlertDialog(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Square Ghost',
            style: TextStyle(
                color: myBackgroundColor,
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
        ),
        actions: const [
          DeleteAccount(),
        ],
      ),
      backgroundColor: myBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (userData != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 1000,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          child: ListTile(
                            title: Text(
                              'Email: ${user.email!}',
                              style: myGFontHomeTextStyle,
                            ),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            title: Text(
                              'Name: ${userData!['name']}',
                              style: myGFontHomeTextStyle,
                            ),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            title: Text(
                              'Age: ${userData!['age']}',
                              style: myGFontHomeTextStyle,
                            ),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            title: Text(
                              'Bio: ${userData!['bio']}',
                              style: myGFontHomeTextStyle,
                            ),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            title: Text(
                              'Gender: ${userData!['gender']}',
                              style: myGFontHomeTextStyle,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        AllOverButton(
                            onTap: () {
                              FirebaseAuth.instance.signOut();
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LogInPage()),
                                  (route) => false);
                            },
                            buttonName: "LOG OUT"),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          foregroundColor: myBackgroundColor,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UpdateUserDataInputPage(
                  existingName: userData!['name'],
                  existingBio: userData!['bio'],
                  existingAge: userData!['age'],
                  existingGender: userData!['gender'] ==
                      'Male', // Assuming you are storing the gender as 'Male' or 'Female'
                ),
              ),
            );
          },
          child: const Icon(
            FontAwesomeIcons.penToSquare,
            color: Colors.white,
          )),
    );
  }
}
