import 'package:flutter/material.dart';
import 'package:ui/components/forms/EducationInputs.dart';
import 'package:ui/SizeConfig.dart';
import 'package:provider/provider.dart';
import '../components/forms/DynamicForm.dart';
import './CreateCard2.dart';
import '../palette.dart';
import '../models/CardInfo.dart';

class CreateCard1 extends StatelessWidget {
  final _createCard1FormKey = GlobalKey<FormState>();
  final educationInputsModel = <Education>[];

  Future nextStep(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CreateCard2()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Create Card (1/3)',
            style: TextStyle(fontFamily: 'Montserrat'),
          ),
        ),
        body: Container(
            margin: EdgeInsets.all(20),
            child: SingleChildScrollView(
                child: Form(
                    key: _createCard1FormKey,
                    child: Column(children: <Widget>[
                      DynamicForm(
                          title: 'Education',
                          inputBuilder: (model) =>
                              EducationInputs(model: model),
                          dynamicModelList: educationInputsModel,
                          dynamicModelBuilder: () => Education()),
                      SizedBox(
                          width: SizeConfig.screenWidth,
                          child: RaisedButton(
                              child: Text('Next'),
                              textColor: Colors.white,
                              color: Palette.primaryGreen,
                              onPressed: () {
                                if (_createCard1FormKey.currentState
                                    .validate()) {
                                  final cardInfoModel =
                                      context.read<CardInfoModel>();
                                  cardInfoModel
                                      .updateEducation(educationInputsModel);
                                  print(cardInfoModel.createUser.toJson());
                                  nextStep(context);
                                }
                              }))
                    ])))));
  }
}
