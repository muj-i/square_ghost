import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:square_ghost/reusable_widgets/all_over_button.dart';
import 'package:square_ghost/reusable_widgets/constants.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // ignore: unused_field
  bool _isSigningUp = false;
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isSigningUp = true;
      });
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: _emailController.text.trim());
        if (mounted) {
          showDialog(
              context: context,
              builder: (context) {
                return const AlertDialog(
                  content: Text('Password reset link sent'),
                );
              });
        }
      } on FirebaseAuthException catch (e) {
        ErrorDialog(errorMessage: e.message.toString())
            .showAlertDialog(context);
      } finally {
        setState(() {
          _isSigningUp = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(appBarTitle: 'Forgot Password'),
      backgroundColor: myBackgroundColor,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              logoWidget('assets/logo/logo.png'),
              Text(
                'Enter Your Email\nWe will send you a password reset link',
                textAlign: TextAlign.center,
                style: myTextStyle,
              ),
              const SizedBox(
                height: 20,
              ),
              //email textfiled
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    labelText: 'Enter Your Email',
                    prefixIcon: Icon(Icons.email_rounded),
                    prefixIconConstraints: BoxConstraints(
                      minWidth: 65,
                    ),
                  ),
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please fill out this field';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Visibility(
                visible: _isSigningUp == false,
                replacement: CircularProgressIndicator(
                  color: Colors.black,
                ),
                child: AllOverButton(
                    onTap: () {
                      passwordReset();
                    },
                    buttonName: "Reset Password"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
