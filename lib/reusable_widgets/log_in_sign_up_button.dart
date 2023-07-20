import 'package:flutter/material.dart';
import 'package:square_ghost/reusable_widgets/constants.dart';

class LogInSignUpButton extends StatelessWidget {
  final Function() onTap;
  final bool isLogin;

  const LogInSignUpButton(
      {super.key, required this.onTap, required this.isLogin});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25,),
      child: SizedBox(
        width: double.infinity ,
        child: Material(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: Colors.black,
          
          child: MaterialButton(
            onPressed: onTap,
            // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
            child: Text(
                isLogin ? 'LOG IN' : 'SIGN UP',
                style: myButtonTextStyle,
              ),
            //color: Colors.black,
          ),
        ),
      ),
    );
  }
}
