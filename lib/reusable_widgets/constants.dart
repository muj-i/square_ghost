import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var myBackgroundColor = Colors.grey[300];

var myGFontTextStyle =
    GoogleFonts.bebasNeue(color: Colors.grey[800], fontSize: 22);

var myTextStyle = TextStyle(color: Colors.grey[800], fontSize: 16);

var myGestureTextStyle = TextStyle(
    color: Colors.grey.shade800, fontSize: 15, fontWeight: FontWeight.bold);

var myButtonTextStyle =
    const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18);

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String appBarTitle;

  const MyAppBar({super.key, required this.appBarTitle});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        appBarTitle,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}

class ErrorDialog {
  final errorMessage;

  const ErrorDialog({required this.errorMessage});
  void showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: myBackgroundColor,
          content: Text(errorMessage, style: myGestureTextStyle,),
        );
      },
    );
  }
}

Image logoWidget(String imageName) {
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width: 240,
    height: 240,
    //color: Colors.white,
  );
}
