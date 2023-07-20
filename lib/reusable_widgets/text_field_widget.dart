import 'package:flutter/material.dart';

class ReusableTextField extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final icon;
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final String labelText;
  final bool obscureText;
   final TextInputType keyboardType;
  const ReusableTextField(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.obscureText, required this.icon, required this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
       keyboardType: keyboardType,

        decoration: InputDecoration(
          
            prefixIcon: Icon(
              icon,
            
            ),prefixIconConstraints: BoxConstraints(
            minWidth: 65,
          ),
            contentPadding: EdgeInsets.symmetric(horizontal: 25,),
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.grey.shade800),
            filled: true,
            fillColor: Colors.grey.shade200,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(color: Colors.white)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(color: Colors.grey.shade400))),
        // keyboardType: isPasswordType ? TextInputType.visiblePassword: TextInputType.emailAddress,
      ),
    );
  }
}
