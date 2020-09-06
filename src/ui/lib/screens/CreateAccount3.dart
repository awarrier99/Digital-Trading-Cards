import 'package:flutter/material.dart';
import 'package:ui/palette.dart';
import 'package:ui/components/forms/InterestsInputs.dart';

import '../components/forms/DynamicForm.dart';
import '../components/forms/SkillsInputs.dart';

class CreateAccount3 extends StatelessWidget {
  Future nextStep(context) async {
    Navigator.pop(context);
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
            DynamicForm('Skills', SkillsInputs()),
            SizedBox(height: 20),
            DynamicForm('Interests', InterestsInputs()),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: RaisedButton(
                      child: Text('Finish'),
                      textColor: Colors.white,
                      color: Palette.primaryGreen,
                      onPressed: () {
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      },
                    )),
              ],
            )
          ])),
        ),
      ),
    );
  }
}
