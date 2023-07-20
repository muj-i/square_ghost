import 'package:flutter/material.dart';

class ReusableTextField extends StatelessWidget {
  final icon;
  final controller;
  final String labelText;
  final bool obscureText;
  final Key? formValidationKey;
   final String? Function(String?)? validator;

  const ReusableTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.obscureText,
    required this.icon,required this.formValidationKey,required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Form(
        key: formValidationKey,
        child: TextFormField(
          controller: controller,
          obscureText: obscureText,

          decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
              ),
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
                  validator: validator,
          // keyboardType: isPasswordType ? TextInputType.visiblePassword: TextInputType.emailAddress,
        ),
      ),
    );
  }
}
