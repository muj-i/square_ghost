import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:square_ghost/reusable_widgets/all_over_button.dart';
import 'package:square_ghost/reusable_widgets/constants.dart';
import 'package:square_ghost/reusable_widgets/selected_gender.dart';

class UpdateUserDataInputPage extends StatefulWidget {
  final String existingName;
  final String existingBio;
  final int existingAge;
  final bool existingGender;
  const UpdateUserDataInputPage(
      {super.key,
      required this.existingName,
      required this.existingBio,
      required this.existingAge,
      required this.existingGender});

  @override
  _UpdateUserDataInputPageState createState() =>
      _UpdateUserDataInputPageState();
}

class _UpdateUserDataInputPageState extends State<UpdateUserDataInputPage> {
  final _nameController = TextEditingController();
  final _bioController = TextEditingController();
  final _ageController = TextEditingController();
  bool _selectedGender = true;
  bool _isLogedIn = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final user = FirebaseAuth.instance.currentUser!;
  Map<String, dynamic>? userData;

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.existingName;
    _bioController.text = widget.existingBio;
    _ageController.text = widget.existingAge.toString();
    _selectedGender = widget.existingGender;
  }

  void updateUserInformation(String name, String bio, int age, bool isMale) {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLogedIn = true;
      });
      String? userId = FirebaseAuth.instance.currentUser?.uid;
      try {
        if (userId != null) {
          DatabaseReference userRef =
              FirebaseDatabase.instance.ref().child('users').child(userId);
          userRef.update({
            'name': name,
            'bio': bio,
            'age': age,
            'gender': _selectedGender ? 'Male' : 'Female',
          }).then((_) {
            const ErrorDialog(
                    errorMessage: 'User information updated successfully!')
                .showAlertDialog(context);
          }).catchError((error) {
            ErrorDialog(errorMessage: error.message.toString())
                .showAlertDialog(context);
          });
        }
      } finally {
        setState(() {
          _isLogedIn = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(30),
        child: AppBar(
          backgroundColor: Colors.transparent,
        ),
      ),
      backgroundColor: myBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                //logo image

                logoNameWidget('assets/logo/logo_name.png'),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Wanna Update Something?",
                  style: myGFontTextStyle,
                ),
                //welcome messeage
                Text(
                  "No Worries! Update your details below",
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
                        return 'Enter valid name';
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
                        return 'Enter valid bio';
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
                        return 'Enter valid age';
                      }
                      return null;
                    },
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
                SelectedGender(
                  existingGender: _selectedGender,
                  onGenderSelected: (isMale) {
                    setState(() {
                      _selectedGender = isMale;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Visibility(
                  visible: _isLogedIn == false,
                  replacement: CircularProgressIndicator(),
                  child: AllOverButton(
                      onTap: () {
                        String name = _nameController.text;
                        String bio = _bioController.text;
                        int age = int.tryParse(_ageController.text) ?? 0;
                        bool isMale =
                            true;
                        updateUserInformation(name, bio, age, isMale);
                        if (_formKey.currentState?.validate() ?? false) {
                          setState(() {
                            _isLogedIn = true;
                            Navigator.pop(context);
                          });
                        }
                      },
                      buttonName: "Update Information"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
