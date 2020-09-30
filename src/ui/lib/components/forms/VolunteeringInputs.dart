import 'package:flutter/material.dart';
import 'package:ui/SizeConfig.dart';

import '../MonthYearPicker.dart';
import '../../models/CardInfo.dart';

class VolunteeringInputs extends StatelessWidget {
  final Volunteering model;
  final FocusNode companyNode = FocusNode();
  final FocusNode descriptionNode = FocusNode();

  VolunteeringInputs({@required this.model});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
            autofocus: true,
            textInputAction: TextInputAction.next,
            cursorColor: Color(0xFF92DAAF),
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                labelText: 'Title*', border: OutlineInputBorder()),
            textCapitalization: TextCapitalization.words,
            initialValue: model.title,
            validator: (value) {
              if (value.isEmpty) {
                return 'Required';
              }
              return null;
            },
            onFieldSubmitted: (term) {
              FocusScope.of(context).requestFocus(companyNode);
            },
            onChanged: (value) {
              model.title = value;
            }),
        SizedBox(height: SizeConfig.safeBlockVertical * 2),
        TextFormField(
            focusNode: companyNode,
            textInputAction: TextInputAction.done,
            cursorColor: Color(0xFF92DAAF),
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                labelText: 'Company*', border: OutlineInputBorder()),
            textCapitalization: TextCapitalization.words,
            initialValue: model.company?.name,
            validator: (value) {
              if (value.isEmpty) {
                return 'Required';
              }
              return null;
            },
            onFieldSubmitted: (term) {
              FocusScope.of(context).requestFocus(descriptionNode);
            },
            onChanged: (value) {
              model.company = Company()..name = value;
            }),
        SizedBox(height: SizeConfig.safeBlockVertical * 2),
        TextFormField(
            focusNode: descriptionNode,
            textInputAction: TextInputAction.done,
            cursorColor: Color(0xFF92DAAF),
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                labelText: 'Description', border: OutlineInputBorder()),
            textCapitalization: TextCapitalization.words,
            maxLines: null,
            initialValue: model.description,
            onChanged: (value) {
              model.description = value;
            }),
        Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              'Start Date',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )),
        MonthYearPicker(
            firstDate: DateTime(DateTime.now().year - 100),
            lastDate: DateTime(DateTime.now().year + 1, 12, 31),
            isRequired: false,
            initialDate: model.startDate,
            onChanged: (value) {
              model.startDate = value;
            }),
        Container(
            margin: EdgeInsets.only(top: 20),
            child: Text('End Date',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
        MonthYearPicker(
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
