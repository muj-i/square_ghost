import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:square_ghost/pages/auth_pages/login_page.dart';
import 'package:square_ghost/pages/home_page.dart';
import 'package:square_ghost/reusable_widgets/constants.dart';
import 'package:square_ghost/reusable_widgets/gender_selection.dart';
import 'package:square_ghost/reusable_widgets/log_in_sign_up_button.dart';

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isSigningUp = false;
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

  //sign up method
  Future signUp() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isSigningUp = true;
      });
      try {
        if (passwordConfirmed()) {
          UserCredential userCredential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );

          if (userCredential.user != null) {
            DatabaseReference userRef =
                FirebaseDatabase.instance.ref().child('users');
            String userId = FirebaseAuth.instance.currentUser!.uid;

            int age = int.tryParse(_ageController.text.trim()) ?? 0;
            userRef.child(userId).set(
              {
                'name': _nameController.text.trim(),
                'age': age,
                'bio': _bioController.text.trim(),
                'gender': _selectedGender ? 'Male' : 'Female',
              },
            );
            if (mounted) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                  (route) => false);
            }
          }
        } else {
          const ErrorDialog(errorMessage: 'Password didn\'t match')
              .showAlertDialog(context);
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

//pass confirm method
  bool passwordConfirmed() {
    if (_passwordController.text == _confirmPasswordController.text) {
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
          child: Form(
            key: _formKey,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: TextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Enter Your Name',
                        prefixIcon: Icon(Icons.person_rounded),
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

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: TextFormField(
                      controller: _bioController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Enter Your Bio',
                        prefixIcon: Icon(Icons.description_rounded),
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

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter
                            .digitsOnly, // Only allow digits
                        LengthLimitingTextInputFormatter(2), // Limit the length
                      ],
                      controller: _ageController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Enter Your Age',
                        prefixIcon: Icon(FontAwesomeIcons.childReaching),
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
                  GenderSelection(
                    onGenderSelected: (isMale) {
                      setState(() {
                        _selectedGender =
                            isMale; // Store the selected gender in the state.
                      });
                    },
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
                      textInputAction: TextInputAction.next,
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

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: TextFormField(
                      controller: _passwordController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Enter Password',
                        prefixIcon: Icon(Icons.lock_rounded),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: TextFormField(
                      controller: _confirmPasswordController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Confirm Password',
                        prefixIcon: Icon(Icons.lock_rounded),
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
                    child: LogInSignUpButton(
                      isLogin: false,
                      onTap: () {
                        signUp();
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  signInOption(),
                  const SizedBox(
                    height: 40,
                  ),
                ]),
          ),
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
