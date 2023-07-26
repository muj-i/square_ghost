// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:square_ghost/pages/home_page.dart';
import 'package:square_ghost/pages/login_page.dart';

import 'package:square_ghost/reusable_widgets/constants.dart';
import 'package:square_ghost/reusable_widgets/gender_selection.dart.dart';
import 'package:square_ghost/reusable_widgets/log_in_sign_up_button.dart';
import 'package:square_ghost/reusable_widgets/text_field_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({
    super.key,
  });

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _nameController = TextEditingController();
  final _bioController = TextEditingController();
  final _ageController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
bool _selectedGender = true;
//dispose for memory management
  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    _ageController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

/////////////
  //sign up method
  Future signUp() async {
    try {
      if (passwordConfirmed()) {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        if (userCredential.user != null) {
         
           DatabaseReference userRef = FirebaseDatabase.instance.reference().child('users');
          String userId = FirebaseAuth.instance.currentUser!.uid;
          userRef.child(userId).set({
            'name': _nameController.text.trim(),
            'age': _ageController.text.trim(),
            'bio': _bioController.text.trim(),
            'gender': _selectedGender ? 'Male' : 'Female', // Replace 'selectedGender' with the actual variable holding the gender value.
          });
         
         
         
         
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
              (route) =>
                  false); // Replace '/home' with the actual route name of your home page.
        }
      }
    } on FirebaseAuthException catch (e) {
      //   print(e);
      ErrorDialog(errorMessage: e.message.toString()).showAlertDialog(context);
    }
  } // Add the addUserDetails method

//pass confirm method
  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                //logo image
                logoNameWidget('assets/logo/logo_name.png'),
                Text(
                  "Hello There",
                  style: myGFontTextStyle,
                ),
                //welcome messeage
                Text(
                  "Register below with your details",
                  style: myTextStyle,
                ),
                const SizedBox(
                  height: 20,
                ),
                ReusableTextField(
                  labelText: 'Enter Your Name',
                  icon: Icons.person_rounded,
                  obscureText: false,
                  controller: _nameController,
                  keyboardType: TextInputType.text,
                  keyboardAction: TextInputAction.next,
                ),
                const SizedBox(
                  height: 20,
                ),
                ReusableTextField(
                  labelText: 'Enter Your Bio',
                  icon: Icons.description_rounded,
                  obscureText: false,
                  controller: _bioController,
                  keyboardType: TextInputType.text,
                  keyboardAction: TextInputAction.next,
                ),
                const SizedBox(
                  height: 20,
                ),
                ReusableTextField(
                  labelText: 'Enter Your Age',
                  icon: FontAwesomeIcons.childReaching,
                  obscureText: false,
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  keyboardAction: TextInputAction.next,
                ),
                const SizedBox(
                  height: 20,
                ),
                GenderSelection(onGenderSelected: (isMale ) { setState(() {
                      _selectedGender = isMale; // Store the selected gender in the state.
                    }); },),
                const SizedBox(
                  height: 20,
                ),

                //email textfiled

                ReusableTextField(
                  labelText: 'Enter Email Address',
                  icon: Icons.email_rounded,
                  obscureText: false,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  keyboardAction: TextInputAction.next,
                ),
                const SizedBox(
                  height: 20,
                ),
                ReusableTextField(
                  labelText: 'Enter Password',
                  icon: Icons.lock_rounded,
                  obscureText: true,
                  controller: _passwordController,
                  keyboardType: TextInputType.text,
                  keyboardAction: TextInputAction.next,
                ),
                const SizedBox(
                  height: 20,
                ),
                ReusableTextField(
                  labelText: 'Confirm Password',
                  icon: Icons.lock_rounded,
                  obscureText: true,
                  controller: _confirmPasswordController,
                  keyboardType: TextInputType.text,
                  keyboardAction: TextInputAction.done,
                ),

                const SizedBox(
                  height: 20,
                ),
                LogInSignUpButton(
                  isLogin: false,
                  onTap: () {
                    signUp();
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                signInOption(),
              ]),
        ),
      ),
    );
  }

//sign in option method
  Row signInOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Have an account?",
          style: myTextStyle,
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LogInPage()),
                (route) => false);
          },
          child: Text(
            " Log In",
            style: myGestureTextStyle,
          ),
        )
      ],
    );
  }
}
