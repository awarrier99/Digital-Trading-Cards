import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui/components/forms/VolunteeringInputs.dart';
import 'package:ui/screens/CreateCard3.dart';
import 'package:ui/components/forms/WorkInputs.dart';
import 'package:ui/SizeConfig.dart';

import '../palette.dart';
import '../components/forms/DynamicForm.dart';
import '../models/CardInfo.dart';

class CreateCard2 extends StatelessWidget {
  final _createCard2FormKey = GlobalKey<FormState>();
  final workInputsModel = <Work>[];
  final volunteeringInputsModel = <Volunteering>[];

  Future nextStep(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CreateCard3()));
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
              key: _createCard2FormKey,
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
                    inputBuilder: (model) => VolunteeringInputs(model: model),
                    dynamicModelList: volunteeringInputsModel,
                    dynamicModelBuilder: () => Volunteering(),
                  ),
                  SizedBox(
                      width: SizeConfig.screenWidth,
                      child: RaisedButton(
                        child: Text('Next'),
                        textColor: Colors.white,
                        color: Palette.primaryGreen,
                        onPressed: () {
                          if (_createCard2FormKey.currentState.validate()) {
                            final cardInfoModel = context.read<CardInfoModel>();
                            cardInfoModel.updateWork(workInputsModel);
                            cardInfoModel.updateVolunteering(volunteeringInputsModel);
                            print(cardInfoModel.createUser.toJson());
                            nextStep(context);
                          }
                        },
                      )),
                ],
              ),
            ),
          ),
        ));
  }
}
