import 'package:flutter/material.dart';
import 'package:ui/components/forms/EducationInputs.dart';
import 'package:ui/SizeConfig.dart';
import 'package:provider/provider.dart';
import '../components/forms/PersonalInfoInputs.dart';
import '../components/forms/DynamicForm.dart';
import './CreateAccount2.dart';
import '../palette.dart';
import '../models/CardInfo.dart';

class CreateCard1 extends StatelessWidget {
  final _createCard1FormKey = GlobalKey<FormState>();
  final personalInfoInputsModel = User();
  final educationInputsModel = [Education()];

  Future nextStep(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CreateAccount2()));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
                  child: Column(children: <Widget>[
                PersonalInfoInputs(
                  key: _createCard1FormKey,
                  model: personalInfoInputsModel,
                ),
                SizedBox(height: 20),
                DynamicForm(
                  title: 'Education',
                  inputBuilder: (model) => EducationInputs(model: model),
                  dynamicModelList: educationInputsModel,
                  dynamicModelBuilder: () => Education()
                ),
                SizedBox(
                    width: SizeConfig.screenWidth,
                    child: RaisedButton(
                      child: Text('Next'),
                      textColor: Colors.white,
                      color: Palette.primaryGreen,
                      onPressed: () {
                        print(personalInfoInputsModel.toJson());

                        if (_createCard1FormKey.currentState.validate()) {
                          nextStep(context);
                        }
                      },
                    )),
              ])),
            )));
  }
}
