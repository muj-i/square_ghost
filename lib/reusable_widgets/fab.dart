import 'package:flutter/material.dart';

class FabButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Icon icon;

  FabButton({required this.onPressed, required this.icon});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.grey.shade800,
      onPressed: onPressed,
      child: icon,
    );
  }
}
