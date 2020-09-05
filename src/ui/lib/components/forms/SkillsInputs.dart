import 'package:flutter/material.dart';

import 'DropdownFormField.dart';

class SkillsInputs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: 'Name'),
          validator: (value) {
            if (value.isEmpty) {
              return 'Required';
            }
            return null;
          },
        ),
        Text('Proficiency Level'),
        DropdownFormField(['Expert', 'Advanced', 'Intermediate', 'Novice'])
      ],
    );
  }
}
