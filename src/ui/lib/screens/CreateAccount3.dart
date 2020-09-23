import 'package:flutter/material.dart';
import 'package:ui/palette.dart';
import 'package:ui/components/forms/InterestsInputs.dart';
import '../components/forms/DynamicForm.dart';
import '../components/forms/SkillsInputs.dart';
import 'package:ui/SizeConfig.dart';
import '../palette.dart';

class CreateAccount3 extends StatelessWidget {
  Future nextStep(context) async {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Card (3/3)',
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
            SizedBox(
                width: SizeConfig.screenWidth,
                child: RaisedButton(
                  child: Text('Submit'),
                  textColor: Colors.white,
                  color: Palette.primaryGreen,
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                )),
          ])),
        ),
      ),
    );
  }
}
