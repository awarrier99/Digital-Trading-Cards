import 'package:flutter/material.dart';

import 'DropdownFormField.dart';

class ExperienceVolunteerInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('New Experience'),
        TextFormField(
          decoration: InputDecoration(labelText: 'Title*'),
          validator: (value) {
            if (value.isEmpty) {
              return 'Required';
            }
            return null;
          },
        ),
        TextFormField(
            decoration: InputDecoration(labelText: 'Company/Organization*'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Required';
              }
              return null;
            }),
        Text('Start Date'),
        Row(children: [
          DropdownFormField([
            'January',
            'February',
            'March',
            'April',
            'May',
            'June',
            'July',
            'August',
            'September',
            'October',
            'November',
            'December'
          ]),
          DropdownFormField(new List<String>.generate(
              10, (i) => (i + DateTime.now().year - 5).toString())),
        ]),
      ],
    );
  }
}
