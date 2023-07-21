import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:square_ghost/reusable_widgets/all_over_button.dart';
import 'package:square_ghost/reusable_widgets/constants.dart';
import 'package:square_ghost/reusable_widgets/text_field_widget.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
          showDialog(
          context: context,
          builder: (context) {
            return  const AlertDialog(
              content: Text('Password reset link sent'),
            );
          });
    } on FirebaseAuthException catch (e) {
      
      ErrorDialog(errorMessage: e.message.toString()).showAlertDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(appBarTitle: 'Forgot Password'),
      backgroundColor: myBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [logoWidget('assets/logo/logo.png'),
            Text(
              'Enter Your Email\nWe will send you a password reset link',
              textAlign: TextAlign.center,
              style: myTextStyle,
            ),
            const SizedBox(
              height: 20,
            ),
            //email textfiled
            ReusableTextField(
              labelText: 'Enter Email Address',
              icon: Icons.email_rounded,
              obscureText: false,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress, keyboardAction: TextInputAction.done,
            ),
            const SizedBox(
              height: 20,
            ),
            AllOverButton(onTap: (){passwordReset();}, buttonName: "Reset Password"),
            
          ],
        ),
      ),
    );
  }
}
