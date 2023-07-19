import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../screens/login_screen.dart';

class DeleteAccount extends StatelessWidget {
  const DeleteAccount({super.key});

  // Function to delete the user account
  void _deleteAccount(BuildContext context) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.delete();
        // If the deletion is successful, navigate to the SignInScreen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LogInScreen()),
        );
      }
    } catch (e) {
      
      print('Error deleting account: $e');
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _deleteAccount(context),
      icon: const Icon(Icons.delete),
    );
  }
}
