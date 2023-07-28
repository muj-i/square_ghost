import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GenderSelection extends StatefulWidget {
  final Function(bool) onGenderSelected;
  
GenderSelection({required this.onGenderSelected});
  @override
  _GenderSelectionState createState() => _GenderSelectionState();
}

class _GenderSelectionState extends State<GenderSelection> {
  bool _isMale = true;

  @override
  Widget build(BuildContext context) {
    TextStyle myTextStyle = TextStyle(color: Colors.grey.shade800);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 1),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(
              FontAwesomeIcons.venusMars,
              size: 17,
              color: Colors.grey.shade800,
            ),
            SizedBox(width: 23),
            Text(
              'Gender: ',
              style: myTextStyle,
            ),
            Radio(
              activeColor: Colors.grey.shade800,
              value: true,
              groupValue: _isMale,
              onChanged: (value) {
                setState(() {
                  _isMale = value!;
                });
                widget.onGenderSelected(_isMale);
              },
            ),
            Text(
              'Male',
              style: myTextStyle,
            ),
            Radio(
              activeColor: Colors.grey.shade800,
              value: false,
              groupValue: _isMale,
              onChanged: (value) {
                setState(() {
                  _isMale = value!;
                });
                widget.onGenderSelected(_isMale);
              },
            ),
            Text(
              'Female',
              style: myTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
