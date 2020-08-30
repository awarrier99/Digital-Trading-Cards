import 'package:flutter/material.dart';

import 'DropdownFormField.dart';

class EducationInputs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: 'School*'),
          validator: (value) {
            if (value.isEmpty) {
              return 'Required';
            }
            return null;
          },
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Major/Subject*'),
          validator: (value) {
            if (value.isEmpty) {
              return 'Required';
            }
            return null;
          },
        ),
        Text('Degree Type (optional)'),
        DropdownFormField(['Associates', 'Bachelors', 'Masters', 'PhD']),
        Text('Graduation Date (optional)'),
        Row(children: [
          DropdownFormField(['Fall', 'Spring', 'Summer']),
          DropdownFormField(new List<String>.generate(
              10, (i) => (i + DateTime.now().year - 5).toString())),
        ])
      ],
    );
  }
}
