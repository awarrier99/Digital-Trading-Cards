import 'package:flutter/material.dart';
import 'package:ui/SizeConfig.dart';

import 'DropdownFormField.dart';
import '../../models/CardInfo.dart';
import '../MonthYearPicker.dart';

class EducationInputs extends StatefulWidget {
  final Education model;

  EducationInputs({@required this.model});

  @override
  EducationInputsState createState() => EducationInputsState();
}

class EducationInputsState extends State<EducationInputs> {
  FocusNode majorNode = FocusNode();
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
    if (widget.model.degree == null) {
      widget.model.degree = 'Associate';
    }
    if (widget.model.startDate == null) {
      widget.model.startDate =
          DateTime(DateTime.now().year, DateTime.now().month);
    }
    if (widget.model.endDate == null) {
      widget.model.endDate = DateTime(DateTime.now().year + 4);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
            autofocus: true,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                labelText: 'Institution*', border: OutlineInputBorder()),
            textCapitalization: TextCapitalization.sentences,
            initialValue: widget.model.institution?.name,
            validator: (value) {
              if (value.isEmpty) {
                return 'Required';
              }
              return null;
            },
            onChanged: (value) {
              widget.model.institution = Institution()..name = value;
            },
            onFieldSubmitted: (term) {
              FocusScope.of(context).requestFocus(majorNode);
            }),
        SizedBox(height: SizeConfig.safeBlockVertical * 2),
        TextFormField(
          focusNode: majorNode,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
              labelText: 'Field of Study*', border: OutlineInputBorder()),
          textCapitalization: TextCapitalization.sentences,
          initialValue: widget.model.field?.name,
          validator: (value) {
            if (value.isEmpty) {
              return 'Required';
            }
            return null;
          },
          onChanged: (value) {
            widget.model.field = Field()..name = value;
          },
        ),
        Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              'Degree Type*',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )),
        DropdownFormField(
          ['Associate', 'Bachelor\'s', 'Master\'s', 'Doctoral'],
          initialValue: widget.model.degree,
          onChanged: (value) {
            widget.model.degree = value;
          },
        ),
        Row(
          children: [
            Container(
                child: Text(
              'Currently Attending',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )),
            Checkbox(
              value: _isCurrent,
              onChanged: (value) {
                setState(() {
                  _isCurrent = value;
                });
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
        Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
                _isCurrent ? 'Expected Graduation Date' : 'Graduation Date*',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
        MonthYearPicker(
            firstDate: DateTime(DateTime.now().year - 100),
            lastDate: DateTime(DateTime.now().year + 6, 12, 31),
            initialDate: widget.model.endDate,
            isRequired: !_isCurrent,
            onChanged: (value) {
              widget.model.endDate = value;
            })
      ],
    );
  }
}
