import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:square_ghost/reusable_widgets/all_over_button.dart';
import 'package:square_ghost/reusable_widgets/constants.dart';
import 'package:square_ghost/reusable_widgets/gender_selection.dart.dart';
import 'package:square_ghost/reusable_widgets/text_field_widget.dart';

class UserDataInputPage extends StatefulWidget {
  const UserDataInputPage({super.key});

  @override
 
  _UserDataInputPageState createState() => _UserDataInputPageState();

   static final GlobalKey<_UserDataInputPageState> userDataInputPageKey =
      GlobalKey<_UserDataInputPageState>();
  
}

class _UserDataInputPageState extends State<UserDataInputPage> {
  final _nameController = TextEditingController();
  final _bioController = TextEditingController();
  final _ageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  Future<dynamic> addUserDetails(String name,String bio,int age,) async {
    await FirebaseFirestore.instance.collection("users").add({
      'name' : name,
      'bio' : bio,
      'age' : age,
      //'gender' :gender,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: MyAppBar(appBarTitle: 'Input Your Data'),
      backgroundColor: myBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              //logo image
              logoWidget('assets/logo/logo.png'),
              Text(
                "Hello There",
                style: myGFontTextStyle,
              ),
              //welcome messeage
              Text(
                "Submit your details below",
                style: myTextStyle,
              ),
              const SizedBox(
                height: 20,
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
              ),
              const SizedBox(
                height: 20,
              ),
              ReusableTextField(
                labelText: 'Enter Your Age',
                icon: FontAwesomeIcons.angellist,
                obscureText: false,
                controller: _ageController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 20,
              ),
              GenderSelection(),
              const SizedBox(
                height: 20,
              ),
              AllOverButton(onTap: () {Navigator.of(context).pop({
          'name': _nameController.text.trim(),
          'bio': _bioController.text.trim(),
          'age': int.tryParse(_ageController.text.trim()) ?? 0,
        });}, buttonName: "Submit"),
            ],
          ),
        ),
      ),
    );
  }
}
