import 'package:flutter/material.dart';

import 'DropdownFormField.dart';

class SkillsInputs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          decoration: InputDecoration(hintText: 'Name'),
          validator: (value) {
            if (value.isEmpty) {
              return 'Required';
            }
            return null;
          },
        ),
        Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              'Proficiency Level',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )),
        DropdownFormField(['Expert', 'Advanced', 'Intermediate', 'Novice'])
      ],
    );
  }
}
