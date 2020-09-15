import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui/palette.dart';
import 'package:ui/SizeConfig.dart';

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
  // FocusNodes initialized for later use to change textField focus when the
  // user hits the continue button on the keyboard.
  FocusNode lastNameNode = FocusNode();
  FocusNode emailNode = FocusNode();
  FocusNode phoneNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Visibility(
            visible: true,
            child: Text('Contact Info',
                style: TextStyle(fontSize: 20, color: Palette.darkGreen)),
          ),
          SizedBox(height: SizeConfig.safeBlockVertical * 2),
          TextFormField(
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  labelText: 'First Name*', border: OutlineInputBorder()),
              textCapitalization: TextCapitalization.words,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Required';
                }
                return null;
              },
              onFieldSubmitted: (term) {
                FocusScope.of(context).requestFocus(lastNameNode);
              }),
          SizedBox(height: SizeConfig.safeBlockVertical * 2),
          TextFormField(
              focusNode: lastNameNode,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  labelText: 'Last Name*', border: OutlineInputBorder()),
              textCapitalization: TextCapitalization.words,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Required';
                }
                return null;
              },
              onFieldSubmitted: (term) {
                FocusScope.of(context).requestFocus(emailNode);
              }),
          SizedBox(height: SizeConfig.safeBlockVertical * 2),
          TextFormField(
              focusNode: emailNode,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  labelText: 'Contact Email*', border: OutlineInputBorder()),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Required';
                }
                return null;
              },
              onFieldSubmitted: (term) {
                FocusScope.of(context).requestFocus(phoneNode);
              }),
          SizedBox(height: SizeConfig.safeBlockVertical * 2),
          TextFormField(
            focusNode: phoneNode,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
                labelText: 'Phone',
                helperText: 'Ex. 012-345-6789',
                border: OutlineInputBorder()),
            keyboardType: TextInputType.phone,
          ),
        ],
      ),
    );
  }
}
