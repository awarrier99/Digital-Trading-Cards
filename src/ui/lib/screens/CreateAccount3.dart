import 'package:flutter/material.dart';

import '../components/forms/DynamicForm.dart';
import '../components/forms/ColorBadge.dart';

class CreateAccount3 extends StatelessWidget {
  final _skillsAndInterestsFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Form(
          child: Column(children: <Widget>[
        DynamicForm('Skills', 'SkillsInputs'),
        ColorBadge('UI/UX Design', Colors.blue, Colors.cyan),
        DynamicForm('Interests', 'InterestsInputs'),
        ColorBadge('Pilates', Colors.pink, Colors.purple),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              child: Text('Finish'),
              textColor: Colors.white,
              color: Color(0xFF92DAAF),
              onPressed: () {
                if (_skillsAndInterestsFormKey.currentState.validate()) {
                  Navigator.pop(context);
                }
              },
            )),
      ])),
    ));
  }
}
