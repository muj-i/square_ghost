import 'package:flutter/material.dart';
import 'package:square_ghost/pages/signup_page.dart';
import 'package:square_ghost/reusable_widgets/constants.dart';

class UserDataInputPage extends StatefulWidget {
  @override
  _UserDataInputPageState createState() => _UserDataInputPageState();
}

class _UserDataInputPageState extends State<UserDataInputPage> {
  final _nameController = TextEditingController();
  final _bioController = TextEditingController();
  final _ageController = TextEditingController();
  bool _isMale = true; // Default value for gender is male

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Data Input'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextFormField(
              controller: _bioController,
              decoration: InputDecoration(labelText: 'Bio'),
            ),
            TextFormField(
              controller: _ageController,
              decoration: InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            Row(
              children: [
                Text('Gender: '),
                Radio(
                  value: true,
                  groupValue: _isMale,
                  onChanged: (value) {
                    setState(() {
                      _isMale = value as bool;
                    });
                  },
                ),
                Text('Male'),
                Radio(
                  value: false,
                  groupValue: _isMale,
                  onChanged: (value) {
                    setState(() {
                      _isMale = value as bool;
                    });
                  },
                ),
                Text('Female'),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                // UserData userData = UserData(
                //   name: _nameController.text.trim(),
                //   bio: _bioController.text.trim(),
                //   age: int.tryParse(_ageController.text) ?? 0,
                //   isMale: _isMale,
                // );
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => SignUpPage(userData: userData),
                //   ),
                // );
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
