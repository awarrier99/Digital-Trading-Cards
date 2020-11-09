import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui/components/forms/VolunteeringInputs.dart';
import 'package:ui/models/Global.dart';
import 'package:ui/screens/CreateCard3.dart';
import 'package:ui/components/forms/WorkInputs.dart';
import 'package:ui/SizeConfig.dart';

import '../palette.dart';
import '../components/forms/DynamicForm.dart';
import '../models/CardInfo.dart';

class CreateCard2 extends StatefulWidget {
  final BuildContext context;

  CreateCard2({this.context});

  @override
  CreateCard2State createState() => CreateCard2State();
}

class CreateCard2State extends State<CreateCard2> {
  final _createCard2FormKey = GlobalKey<FormState>();
  List<Work> workInputsModel;
  List<Volunteering> volunteeringInputsModel;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    final globalModel = widget.context.read<GlobalModel>();
    final currentCard = globalModel.cardInfoModel.currentUserCardInfo;
    workInputsModel = currentCard.work;
    volunteeringInputsModel = currentCard.volunteering;
    isEditing = globalModel.cardInfoModel.isEditing;
  }

  Future nextStep(context) async {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => CreateCard3(context: context)));
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
                      onDelete: (idx) {
                        final globalModel = context.read<GlobalModel>();
                        final id = workInputsModel[idx]?.id;
                        if (isEditing && id != null)
                          globalModel.cardInfoModel.deleteLists['work']
                              .add(workInputsModel[idx]);
                      }),
                  SizedBox(height: 20),
                  DynamicForm(
                      title: 'Volunteer Experience',
                      inputBuilder: (model) => VolunteeringInputs(model: model),
                      dynamicModelList: volunteeringInputsModel,
                      dynamicModelBuilder: () => Volunteering(),
                      onDelete: (idx) {
                        final globalModel = context.read<GlobalModel>();
                        final id = volunteeringInputsModel[idx]?.id;
                        if (isEditing && id != null)
                          globalModel.cardInfoModel.deleteLists['volunteering']
                              .add(volunteeringInputsModel[idx]);
                      }),
                  SizedBox(
                      width: SizeConfig.screenWidth,
                      child: RaisedButton(
                        child: Text('Next'),
                        textColor: Colors.white,
                        color: Palette.primary,
                        onPressed: () {
                          if (_createCard2FormKey.currentState.validate()) {
                            final globalModel = context.read<GlobalModel>();
                            final cardInfoModel = globalModel.cardInfoModel;
                            cardInfoModel.updateWork(workInputsModel);
                            cardInfoModel
                                .updateVolunteering(volunteeringInputsModel);
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
