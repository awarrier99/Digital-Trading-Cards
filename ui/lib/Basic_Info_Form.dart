import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Create a Form widget.
class BasicInfoForm extends StatefulWidget {
  final GlobalKey key;

  BasicInfoForm(this.key);

  @override
  BasicInfoFormState createState() {
    return BasicInfoFormState();
  }
}

class BasicInfoFormState extends State<BasicInfoForm> {
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
                    color: Color(0xFF92DAAF),
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
