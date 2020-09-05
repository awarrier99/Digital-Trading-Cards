import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui/palette.dart';

// Create a Form widget.
class PersonalInfoInputs extends StatefulWidget {
  final GlobalKey key;

  PersonalInfoInputs(this.key);

  @override
  PersonalInfoInputsState createState() {
    return PersonalInfoInputsState();
  }
}

class PersonalInfoInputsState extends State<PersonalInfoInputs> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Visibility(
              visible: true,
              child: Text(
                'Contact Info',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Palette.primaryGreen,
                    fontSize: 18),
              )),
          TextFormField(
            decoration: InputDecoration(labelText: 'First Name*'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Required';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Last Name*'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Required';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Contact Email*'),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value.isEmpty) {
                return 'Required';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Phone',
              helperText: 'Ex. 012-345-6789',
            ),
            keyboardType: TextInputType.phone,
          ),
        ],
      ),
    );
  }
}
