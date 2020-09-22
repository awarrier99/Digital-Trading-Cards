import 'package:flutter/material.dart';
import 'package:ui/screens/CreateAccount3.dart';
import '../components/forms/DynamicForm.dart';
import 'package:ui/components/forms/ExperienceVolunteerInput.dart';
import 'package:ui/SizeConfig.dart';
import '../palette.dart';

class CreateAccount2 extends StatelessWidget {
  Future navigateToCreateAccount3(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CreateAccount3()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Create Card (2/3)'),
        ),
        body: Container(
          margin: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                children: [
                  DynamicForm('Work Experience', ExperienceVolunteerInput()),
                  DynamicForm(
                      'Volunteer Experience', ExperienceVolunteerInput()),
                  SizedBox(
                      width: SizeConfig.screenWidth,
                      child: RaisedButton(
                        child: Text('Next'),
                        textColor: Colors.white,
                        color: Palette.primaryGreen,
                        onPressed: () {
                          navigateToCreateAccount3(context);
                        },
                      )),
                ],
              ),
            ),
          ),
        ));
  }
}
