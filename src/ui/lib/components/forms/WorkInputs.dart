import 'package:flutter/material.dart';
import 'package:ui/SizeConfig.dart';
import 'package:ui/components/TextInput.dart';

import '../MonthYearPicker.dart';
import '../../models/CardInfo.dart';

class WorkInputs extends StatefulWidget {
  final Work model;

  WorkInputs({@required this.model});

  @override
  WorkInputsState createState() => WorkInputsState();
}

class WorkInputsState extends State<WorkInputs> {
  FocusNode companyNode = FocusNode();
  FocusNode descriptionNode = FocusNode();
  bool _isCurrent;

  @override
  void initState() {
    super.initState();
    if (widget.model.current == null) {
      _isCurrent = false;
      widget.model.current = false;
    } else {
      _isCurrent = widget.model.current;
    }
    if (widget.model.startDate == null) {
      widget.model.startDate =
          DateTime(DateTime.now().year, DateTime.now().month);
    }
    if (widget.model.endDate == null) {
      widget.model.endDate =
          DateTime(DateTime.now().year + 1, DateTime.now().month);
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextInput(
            autofocus: true,
            textInputAction: TextInputAction.next,
            cursorColor: Color(0xFF92DAAF),
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                labelText: 'Job Title*', border: OutlineInputBorder()),
            textCapitalization: TextCapitalization.words,
            initialValue: widget.model.jobTitle,
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
              widget.model.jobTitle = value;
            }),
        SizedBox(height: SizeConfig.safeBlockVertical * 2),
        TextInput(
            focusNode: companyNode,
            textInputAction: TextInputAction.done,
            cursorColor: Color(0xFF92DAAF),
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                labelText: 'Company*', border: OutlineInputBorder()),
            textCapitalization: TextCapitalization.words,
            initialValue: widget.model.company?.name,
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
              widget.model.company = Company()..name = value;
            }),
        SizedBox(height: SizeConfig.safeBlockVertical * 2),
        TextInput(
            focusNode: descriptionNode,
            textInputAction: TextInputAction.done,
            cursorColor: Color(0xFF92DAAF),
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                labelText: 'Description', border: OutlineInputBorder()),
            textCapitalization: TextCapitalization.words,
            maxLines: null,
            initialValue: widget.model.description,
            onChanged: (value) {
              widget.model.description = value;
            }),
        Row(
          children: [
            Container(
                child: Text(
              'Currently Working',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )),
            Checkbox(
              value: _isCurrent,
              onChanged: (value) {
                setState(() {
                  _isCurrent = value;
                });
                if (value)
                  widget.model.endDate = null;
                else
                  widget.model.endDate =
                      DateTime(DateTime.now().year + 1, DateTime.now().month);
                widget.model.current = value;
              },
            )
          ],
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
        Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              'Start Date*',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )),
        MonthYearPicker(
            firstDate: DateTime(DateTime.now().year - 100),
            lastDate: DateTime(DateTime.now().year + 1, 12, 31),
            initialDate: widget.model.startDate,
            onChanged: (value) {
              widget.model.startDate = value;
            }),
        _isCurrent
            ? SizedBox.shrink()
            : Container(
                margin: EdgeInsets.only(top: 20),
                child: Text('End Date*',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
        _isCurrent
            ? SizedBox.shrink()
            : MonthYearPicker(
                firstDate: DateTime(DateTime.now().year - 100),
                lastDate: DateTime(DateTime.now().year, DateTime.now().month),
                initialDate: widget.model.endDate,
                isRequired: !_isCurrent,
                onChanged: (value) {
                  widget.model.endDate = value;
                })
      ],
    );
  }
}
