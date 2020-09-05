import 'package:flutter/material.dart';
import 'package:ui/screens/CreateAccount3.dart';
import '../components/forms/DynamicForm.dart';
import 'package:ui/components/forms/ExperienceVolunteerInput.dart';

class CreateAccount2 extends StatelessWidget {
  Future navigateToCreateAccount3(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CreateAccount3()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              DynamicForm('Work Experience', ExperienceVolunteerInput()),
              DynamicForm('Volunteer Experience', ExperienceVolunteerInput()),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: RaisedButton(
                  child: Text('Next'),
                  textColor: Colors.white,
                  color: Color(0xFF92DAAF),
                  onPressed: () {
                    navigateToCreateAccount3(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
