import 'package:flutter/material.dart';

import './Basic_Info_Form.dart';
import '../components/forms/DynamicForm.dart';

class CreateAccount extends StatelessWidget {
  final _createAccountFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Form(
          child: Column(children: <Widget>[
        BasicInfoForm(_createAccountFormKey),
        DynamicForm('Education'),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              child: Text('Next'),
              textColor: Colors.white,
              color: Color(0xFF92DAAF),
              onPressed: () {
                if (_createAccountFormKey.currentState.validate()) {
                  Navigator.pop(context);
                }
              },
            )),
      ])),
    ));
  }
}
