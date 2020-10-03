import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui/models/Global.dart';
import 'package:ui/models/User.dart';
import 'package:ui/palette.dart';
import 'package:ui/components/forms/InterestsInputs.dart';
import '../components/forms/DynamicForm.dart';
import '../components/forms/SkillsInputs.dart';
import 'package:ui/SizeConfig.dart';
import '../palette.dart';
import 'Home.dart';
import '../models/CardInfo.dart';

class CreateCard3 extends StatefulWidget {
  final BuildContext context;

  CreateCard3({this.context});

  @override
  CreateCard3State createState() => CreateCard3State();
}

class CreateCard3State extends State<CreateCard3> {
  final _createCard3FormKey = GlobalKey<FormState>();
  List<UserSkill> skillsInputsModel;
  List<UserInterest> interestsInputsModel;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    final globalModel = widget.context.read<GlobalModel>();
    final currentCard = globalModel.cardInfoModel.currentUserCardInfo;
    skillsInputsModel = currentCard.skills;
    interestsInputsModel = currentCard.interests;
    isEditing = globalModel.cardInfoModel.isEditing;
  }

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
                    dynamicModelBuilder: () => UserSkill(),
                    onDelete: (idx) {
                      final globalModel = context.read<GlobalModel>();
                      final id = skillsInputsModel[idx]?.id;
                      if (isEditing && id != null)
                        globalModel.cardInfoModel.deleteLists['skills']
                            .add(skillsInputsModel[idx]);
                    }),
                SizedBox(height: 20),
                DynamicForm(
                    title: 'Interests',
                    inputBuilder: (model) => InterestsInputs(model: model),
                    dynamicModelList: interestsInputsModel,
                    dynamicModelBuilder: () => UserInterest(),
                    onDelete: (idx) {
                      final globalModel = context.read<GlobalModel>();
                      final id = interestsInputsModel[idx]?.id;
                      if (isEditing && id != null)
                        globalModel.cardInfoModel.deleteLists['interests']
                            .add(interestsInputsModel[idx]);
                    }),
                SizedBox(
                    width: SizeConfig.screenWidth,
                    child: RaisedButton(
                      child: Text('Submit'),
                      textColor: Colors.white,
                      color: Palette.primaryGreen,
                      onPressed: () {
                        if (_createCard3FormKey.currentState.validate()) {
                          final globalModel = context.read<GlobalModel>();
                          final userModel = globalModel.userModel;
                          final cardInfoModel = globalModel.cardInfoModel;
                          cardInfoModel.updateSkills(skillsInputsModel);
                          cardInfoModel.updateInterests(interestsInputsModel);
                          if (isEditing) {
                            cardInfoModel
                                .updateCard(
                                    userModel.currentUser.id, userModel.token)
                                .then((success) {
                              if (success) nextStep(context);
                            });
                          } else {
                            cardInfoModel
                                .createCard(userModel.token)
                                .then((success) {
                              if (success) nextStep(context);
                            });
                          }
                        }
                      },
                    )),
              ])),
        ),
      ),
    );
  }
}
