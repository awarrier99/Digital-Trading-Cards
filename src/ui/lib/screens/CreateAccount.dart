import 'package:flutter/material.dart';

import '../components/forms/PersonalInfoInputs.dart';
// import 'BasicInfoForm.dart';
import '../components/forms/DynamicForm.dart';
import 'package:ui/components/forms/EducationInputs.dart';
import 'package:ui/screens/CreateAccount2.dart';

class CreateAccount extends StatelessWidget {
  // final _createAccountFormKey = GlobalKey<FormState>();

  Future navigateToCreateAccount2(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CreateAccount2()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Form(
          child: Column(children: <Widget>[
        // PersonalInfoInputs(_createAccountFormKey),
        DynamicForm('Education', EducationInputs()),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              child: Text('Next'),
              textColor: Colors.white,
              color: Color(0xFF92DAAF),
              onPressed: () {
                navigateToCreateAccount2(context);
              },
            )),
      ])),
    ));
  }
}
