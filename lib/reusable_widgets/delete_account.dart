import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:square_ghost/pages/auth_pages/login_page.dart';
import 'package:square_ghost/reusable_widgets/constants.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  // Function to delete the user account
  void _deleteAccount(BuildContext context) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String userId = user.uid;
        DatabaseReference userRef =
            FirebaseDatabase.instance.ref().child('users').child(userId);
        await userRef.remove();
        await user.delete();
        await FirebaseAuth.instance.signOut();
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LogInPage(),
            ),
          );
        }
      }
    } catch (e) {
      ErrorDialog(errorMessage: e.toString()).showAlertDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: myBackgroundColor,
              content: Text(
                'Wanna delete account?',
                style: myGestureTextStyle,
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel',style: TextStyle(color: Colors.black),)),
                TextButton(
                    onPressed: () {
                      _deleteAccount(context);
                    },
                    child: Text('Delete',style: TextStyle(color: Colors.redAccent),)),

              ],
            );
          },
        );},
      icon: Icon(
        FontAwesomeIcons.trash,
        size: 19,
        color: myBackgroundColor,
      ),
    );
  }
}
