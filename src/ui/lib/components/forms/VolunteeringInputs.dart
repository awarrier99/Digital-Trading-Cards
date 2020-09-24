import 'package:flutter/material.dart';
import 'package:ui/SizeConfig.dart';

import '../MonthYearPicker.dart';
import '../../models/CardInfo.dart';

class VolunteeringInputs extends StatefulWidget {
  final Volunteering model;

  VolunteeringInputs({@required this.model});

  @override
  VolunteeringInputsState createState() => VolunteeringInputsState();
}

class VolunteeringInputsState extends State<VolunteeringInputs> {
  FocusNode companyNode = FocusNode();
  FocusNode descriptionNode = FocusNode();

  @override
  void initState() {
    super.initState();
    widget.model.startDate = DateTime(DateTime.now().year, DateTime.now().month);
  }

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
                labelText: 'Title*', border: OutlineInputBorder()
            ),
            textCapitalization: TextCapitalization.words,
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
              widget.model.title = value;
            }
        ),
        SizedBox(height: SizeConfig.safeBlockVertical * 2),
        TextFormField(
            focusNode: companyNode,
            textInputAction: TextInputAction.done,
            cursorColor: Color(0xFF92DAAF),
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                labelText: 'Company*',
                border: OutlineInputBorder()
            ),
            textCapitalization: TextCapitalization.words,
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
              widget.model.company = Company()
                ..name = value;
            }
        ),
        SizedBox(height: SizeConfig.safeBlockVertical * 2),
        TextFormField(
            focusNode: descriptionNode,
            textInputAction: TextInputAction.done,
            cursorColor: Color(0xFF92DAAF),
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder()
            ),
            textCapitalization: TextCapitalization.words,
            maxLines: null,
            onChanged: (value) {
              widget.model.description = value;
            }
        ),
        Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              'Start Date',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )
        ),
        MonthYearPicker(
            firstDate: DateTime(DateTime.now().year - 100),
            lastDate: DateTime(DateTime.now().year + 1, 12, 31),
            initialDate: DateTime(DateTime.now().year, DateTime.now().month),
            isRequired: false,
            onChanged: (value) {
              widget.model.startDate = value;
            }
        ),
        Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
                'End Date',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
            )
        ),
        MonthYearPicker(
            firstDate: DateTime(DateTime.now().year - 100),
            lastDate: DateTime(DateTime.now().year, DateTime.now().month),
            isRequired: false,
            onChanged: (value) {
              widget.model.endDate = value;
            }
        )
      ],
    );
  }
}
