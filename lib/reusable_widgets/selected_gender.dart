import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SelectedGender extends StatefulWidget {
  final Function(bool) onGenderSelected;
  final bool existingGender;
  const SelectedGender(
      {super.key,
      required this.onGenderSelected,
      required this.existingGender});
  @override
  // ignore: library_private_types_in_public_api
  _SelectedGenderState createState() => _SelectedGenderState();
}

class _SelectedGenderState extends State<SelectedGender> {
  bool? _isMale;
  @override
  void initState() {
    super.initState();
    _isMale =
        widget.existingGender; // Set the initial value from the existing gender
  }

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
            const SizedBox(width: 23),
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
                widget.onGenderSelected(_isMale!);
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
                widget.onGenderSelected(_isMale!);
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
