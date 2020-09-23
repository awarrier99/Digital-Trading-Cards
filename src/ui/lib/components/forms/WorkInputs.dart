import 'package:flutter/material.dart';
import 'package:ui/SizeConfig.dart';

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
  bool _isCurrent;

  @override
  void initState() {
    super.initState();
    _isCurrent = false;
    widget.model.current = false;
    widget.model.startDate = DateTime(DateTime.now().year, DateTime.now().month);
    widget.model.endDate = DateTime(DateTime.now().year, DateTime.now().month);
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
              labelText: 'Job Title*', border: OutlineInputBorder()
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
            widget.model.jobTitle = value;
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
          onChanged: (value) {
            widget.model.company = Company()
              ..name = value;
          }
        ),
        Row(
          children: [
            Container(
                child: Text(
                  'Currently Working',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                )
            ),
            Checkbox(
              value: _isCurrent,
              onChanged: (value) {
                setState(() {
                  _isCurrent = value;
                });
                if (value) widget.model.endDate = null;
                else widget.model.endDate = DateTime(DateTime.now().year, DateTime.now().month);
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
            )
        ),
        MonthYearPicker(
            firstDate: DateTime(DateTime.now().year - 100),
            lastDate: DateTime(DateTime.now().year + 1, 12, 31),
            initialDate: DateTime(DateTime.now().year, DateTime.now().month),
            onChanged: (value) {
              widget.model.startDate = value;
            }
        ),
        _isCurrent ? SizedBox.shrink() : Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
                'End Date*',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
            )
        ),
        _isCurrent ? SizedBox.shrink() : MonthYearPicker(
            firstDate: DateTime(DateTime.now().year - 100),
            lastDate: DateTime(DateTime.now().year, DateTime.now().month),
            initialDate: DateTime(DateTime.now().year + 4),
            onChanged: (value) {
              widget.model.endDate = value;
            }
        )
      ],
    );
  }
}
