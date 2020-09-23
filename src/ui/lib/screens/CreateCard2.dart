import 'package:flutter/material.dart';
import 'package:ui/screens/CreateAccount3.dart';
import 'package:ui/components/forms/WorkInputs.dart';
import 'package:ui/SizeConfig.dart';

import '../palette.dart';
import '../components/forms/DynamicForm.dart';
import '../models/CardInfo.dart';

class CreateCard2 extends StatelessWidget {
  final workInputsModel = <Work>[];
  final volunteeringInputsModel = <Volunteering>[];

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
                  DynamicForm(
                    title: 'Work Experience',
                    inputBuilder: (model) => WorkInputs(model: model),
                    dynamicModelList: workInputsModel,
                    dynamicModelBuilder: () => Work(),
                  ),
                  DynamicForm(
                      title: 'Volunteer Experience',
                      inputBuilder: (model) => WorkInputs(model: model)
                  ),
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
