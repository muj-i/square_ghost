import 'package:flutter/material.dart';

var myBackgroundColor = Colors.grey[300];

var myTextStyle = TextStyle(color: Colors.grey[800], fontSize: 16);

class MyAppBar extends StatelessWidget implements PreferredSizeWidget{
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
  
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
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
