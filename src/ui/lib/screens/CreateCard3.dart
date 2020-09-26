import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui/models/User.dart';
import 'package:ui/palette.dart';
import 'package:ui/components/forms/InterestsInputs.dart';
import '../components/forms/DynamicForm.dart';
import '../components/forms/SkillsInputs.dart';
import 'package:ui/SizeConfig.dart';
import '../palette.dart';
import 'Home.dart';
import '../models/CardInfo.dart';

class CreateCard3 extends StatelessWidget {
  final _createCard3FormKey = GlobalKey<FormState>();
  final skillsInputsModel = <Skill>[];
  final interestsInputsModel = <Interest>[];

  Future nextStep(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
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
              key: _createCard3FormKey,
              child: Column(children: <Widget>[
                DynamicForm(
                  title: 'Skills',
                  inputBuilder: (model) => SkillsInputs(model: model),
                  dynamicModelList: skillsInputsModel,
                  dynamicModelBuilder: () => Skill(),
                ),
                SizedBox(height: 20),
                DynamicForm(
                  title: 'Interests',
                  inputBuilder: (model) => InterestsInputs(model: model),
                  dynamicModelList: interestsInputsModel,
                  dynamicModelBuilder: () => Interest(),
                ),
                SizedBox(
                    width: SizeConfig.screenWidth,
                    child: RaisedButton(
                      child: Text('Submit'),
                      textColor: Colors.white,
                      color: Palette.primaryGreen,
                      onPressed: () {
                        final userModel = context.read<UserModel>();

                        if (_createCard3FormKey.currentState.validate()) {
                          final cardInfoModel = context.read<CardInfoModel>();
                          cardInfoModel.updateSkills(skillsInputsModel);
                          cardInfoModel.updateInterests(interestsInputsModel);
                          cardInfoModel
                              .createCard(userModel.token)
                              .then((success) {
                            if (success) nextStep(context);
                          });
                        }
                      },
                    )),
              ])),
        ),
      ),
    );
  }
}
