import 'package:flutter/material.dart';
import 'package:ui/components/forms/EducationInputs.dart';

import '../components/forms/PersonalInfoInputs.dart';
import '../components/forms/DynamicForm.dart';
import './CreateAccount2.dart';
import '../palette.dart';

class CreateCard1 extends StatelessWidget {
  final _createCard1FormKey = GlobalKey<FormState>();

  Future nextStep(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CreateAccount2()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Create Card',
            style: TextStyle(fontFamily: 'Montserrat'),
          ),
        ),
        body: Container(
            margin: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Form(
                  child: Column(children: <Widget>[
                PersonalInfoInputs(_createCard1FormKey),
                SizedBox(height: 20),
                DynamicForm('Education', EducationInputs()),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: RaisedButton(
                        child: Text('Next'),
                        textColor: Colors.white,
                        color: Palette.primaryGreen,
                        onPressed: () {
                          if (_createCard1FormKey.currentState.validate()) {
                            nextStep(context);
                          }
                        },
                      ))
                ]),
              ])),
            )));
  }
}
