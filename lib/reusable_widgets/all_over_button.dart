import 'package:flutter/material.dart';
import 'package:square_ghost/reusable_widgets/constants.dart';

class AllOverButton extends StatelessWidget {
  final Function() onTap;
  final String buttonName;

  const AllOverButton({
    super.key,
    required this.onTap,
    required this.buttonName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
      ),
      child: SizedBox(
        width: double.infinity,
        child: Material(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: Colors.black,
          child: MaterialButton(
            onPressed: onTap,
            // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
            child: Text(
              buttonName,
              style: myButtonTextStyle,
            ),
            //color: Colors.black,
          ),
        ),
      ),
    );
  }
}
