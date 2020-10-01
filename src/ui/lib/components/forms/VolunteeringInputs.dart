import 'package:flutter/material.dart';
import 'package:ui/SizeConfig.dart';
import 'package:ui/components/TextInput.dart';

import '../MonthYearPicker.dart';
import '../../models/CardInfo.dart';

class VolunteeringInputs extends StatelessWidget {
  final Volunteering model;
  final FocusNode companyNode = FocusNode();
  final FocusNode descriptionNode = FocusNode();
  final FocusNode startDateNode = FocusNode();
  final FocusNode endDateNode = FocusNode();

  VolunteeringInputs({@required this.model});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextInput(
            autofocus: true,
            cursorColor: Color(0xFF92DAAF),
            label: 'Title*',
            textCapitalization: TextCapitalization.words,
            initialValue: model.title,
            validator: (value) {
              if (value.isEmpty) {
                return 'Required';
              }
              return null;
            },
            onEditingComplete: () {
              FocusScope.of(context).requestFocus(companyNode);
            },
            onChanged: (value) {
              model.title = value;
            }),
        SizedBox(height: SizeConfig.safeBlockVertical * 2),
        TextInput(
            focusNode: companyNode,
            cursorColor: Color(0xFF92DAAF),
            label: 'Company*',
            textCapitalization: TextCapitalization.words,
            initialValue: model.company?.name,
            validator: (value) {
              if (value.isEmpty) {
                return 'Required';
              }
              return null;
            },
            onEditingComplete: () {
              FocusScope.of(context).requestFocus(descriptionNode);
            },
            onChanged: (value) {
              model.company = Company()..name = value;
            }),
        SizedBox(height: SizeConfig.safeBlockVertical * 2),
        TextInput(
            focusNode: descriptionNode,
            cursorColor: Color(0xFF92DAAF),
            decoration: InputDecoration(
                labelText: 'Description', border: OutlineInputBorder()),
            textCapitalization: TextCapitalization.sentences,
            maxLines: null,
            initialValue: model.description,
            onChanged: (value) {
              model.description = value;
            },
            onEditingComplete: () {
              FocusScope.of(context).requestFocus(startDateNode);
            }),
        Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              'Start Date',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )),
        MonthYearPicker(
            focusNode: startDateNode,
            firstDate: DateTime(DateTime.now().year - 100),
            lastDate: DateTime(DateTime.now().year + 1, 12, 31),
            isRequired: false,
            initialDate: model.startDate,
            onChanged: (value) {
              model.startDate = value;
            },
            onEditingComplete: () {
              FocusScope.of(context).requestFocus(endDateNode);
            }),
        Container(
            margin: EdgeInsets.only(top: 20),
            child: Text('End Date',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
        MonthYearPicker(
            focusNode: endDateNode,
            firstDate: DateTime(DateTime.now().year - 100),
            lastDate: DateTime(DateTime.now().year, DateTime.now().month),
            isRequired: false,
            initialDate: model.endDate,
            onChanged: (value) {
              model.endDate = value;
            })
      ],
    );
  }
}
