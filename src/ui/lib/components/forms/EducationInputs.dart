import 'package:flutter/material.dart';

import 'DropdownFormField.dart';

class EducationInputs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
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
        Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              'Degree Type*',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )),
        DropdownFormField(['Associates', 'Bachelors', 'Masters', 'PhD']),
        Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              'Graduation Date',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )),
        Row(children: [
          DropdownFormField(['Fall', 'Spring', 'Summer']),
          DropdownFormField(new List<String>.generate(
              10, (i) => (i + DateTime.now().year - 5).toString())),
        ])
      ],
    );
  }
}
