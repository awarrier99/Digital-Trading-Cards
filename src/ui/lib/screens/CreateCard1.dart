import 'package:flutter/material.dart';
import 'package:ui/components/forms/EducationInputs.dart';
import 'package:ui/SizeConfig.dart';
import 'package:provider/provider.dart';
import 'package:ui/models/Global.dart';
import '../components/forms/DynamicForm.dart';
import './CreateCard2.dart';
import '../palette.dart';
import '../models/CardInfo.dart';

class CreateCard1 extends StatefulWidget {
  final BuildContext context;

  CreateCard1({this.context});

  @override
  CreateCard1State createState() => CreateCard1State();
}

class CreateCard1State extends State<CreateCard1> {
  final _createCard1FormKey = GlobalKey<FormState>();
  List<Education> educationInputsModel;
  bool isEditing;

  @override
  void initState() {
    super.initState();
    final globalModel = widget.context.read<GlobalModel>();
    final currentCard = globalModel.cardInfoModel.currentUserCardInfo;
    educationInputsModel = currentCard.education ?? [];
    isEditing = globalModel.cardInfoModel.isEditing;
  }

  Future nextStep(context) async {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => CreateCard2(context: context)));
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
                          dynamicModelBuilder: () => Education(),
                          onDelete: (idx) {
                            final globalModel = context.read<GlobalModel>();
                            final id = educationInputsModel[idx]?.id;
                            if (isEditing && id != null)
                              globalModel.cardInfoModel.deleteLists['education']
                                  .add(educationInputsModel[idx]);
                          }),
                      SizedBox(
                          width: SizeConfig.screenWidth,
                          child: RaisedButton(
                              child: Text('Next'),
                              textColor: Colors.white,
                              color: Palette.primary,
                              onPressed: () {
                                if (_createCard1FormKey.currentState
                                    .validate()) {
                                  final globalModel =
                                      context.read<GlobalModel>();
                                  final cardInfoModel =
                                      globalModel.cardInfoModel;
                                  cardInfoModel
                                      .updateEducation(educationInputsModel);
                                  nextStep(context);
                                }
                              }))
                    ])))));
  }
}
