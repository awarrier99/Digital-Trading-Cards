import 'package:flutter/material.dart';
import 'DropdownFormField.dart';
import 'package:ui/SizeConfig.dart';

class ExperienceVolunteerInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      children: [
        TextFormField(
          cursorColor: Color(0xFF92DAAF),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              labelText: 'Title*', border: OutlineInputBorder()),
          validator: (value) {
            if (value.isEmpty) {
              return 'Required';
            }
            return null;
          },
        ),
        SizedBox(height: SizeConfig.safeBlockVertical * 2),
        TextFormField(
            cursorColor: Color(0xFF92DAAF),
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                labelText: 'Company/Organization*',
                border: OutlineInputBorder()),
            validator: (value) {
              if (value.isEmpty) {
                return 'Required';
              }
              return null;
            }),
        SizedBox(height: SizeConfig.safeBlockVertical * 2),
        Text('Start Date',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
          SizedBox(width: SizeConfig.safeBlockVertical * 2),
          DropdownFormField(new List<String>.generate(
              10, (i) => (i + DateTime.now().year - 5).toString())),
        ]),
        SizedBox(height: SizeConfig.safeBlockVertical * 2),
        Text('End Date',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
          SizedBox(width: SizeConfig.safeBlockVertical * 2),
          DropdownFormField(new List<String>.generate(
              10, (i) => (i + DateTime.now().year - 5).toString())),
        ]),
      ],
    );
  }
}
