import 'package:flutter/material.dart';
import 'package:ui/components/AutoComplete.dart';
import 'package:provider/provider.dart';
import 'package:ui/components/CreateSkillDialog.dart';
import 'package:ui/models/Global.dart';

import 'DropdownFormField.dart';
import '../../models/CardInfo.dart';

class SkillsInputs extends StatefulWidget {
  final UserSkill model;

  SkillsInputs({@required this.model});

  @override
  SkillsInputsState createState() => SkillsInputsState();
}

class SkillsInputsState extends State<SkillsInputs> {
  Future<List<dynamic>> getSkillSuggestions(String pattern) async {
    try {
      final globalModel = context.read<GlobalModel>();
      return globalModel.getSuggestions(
          '/api/skills', pattern, 'skills', () => Skill());
    } catch (err) {
      print('An error occurred while trying to get suggested skills:');
      print(err);
      return [];
    }
  }

  void createSkill(String value) {
    showDialog(context: context, builder: (_) => CreateSkillDialog(value));
  }

  Widget skillItemBuilder(BuildContext context, dynamic suggestion) {
    return ListTile(
        leading: Icon(Icons.list), title: Text((suggestion as Skill).title));
  }

  void onSkillSuggestionSelected(
      dynamic selection, TextEditingController controller) {
    controller.text = (selection as Skill).title;
    widget.model.skill = selection as Skill;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoComplete(
            autofocus: true,
            decoration:
                InputDecoration(hintText: 'Title*', border: OutlineInputBorder()),
            textCapitalization: TextCapitalization.sentences,
            initialValue: widget.model.skill?.title,
            validator: (value) {
              if (value.isEmpty) {
                return 'Required';
              }
              return null;
            },
            getSuggestions: getSkillSuggestions,
            itemBuilder: skillItemBuilder,
            onSuggestionSelected: onSkillSuggestionSelected,
            onNoItemsFound: (value) {
              createSkill(value);
            }),
        Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              'Proficiency Level',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )),
        DropdownFormField(['Expert', 'Advanced', 'Intermediate', 'Novice'])
      ],
    );
  }
}
