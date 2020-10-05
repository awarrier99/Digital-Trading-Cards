import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ui/SizeConfig.dart';
import 'package:ui/components/AutoComplete.dart';
import 'package:ui/components/CreateInstitutionDialog.dart';
import 'package:ui/components/CreateFieldDialog.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:ui/models/Global.dart';

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
  FocusNode startDateNode = FocusNode();
  FocusNode endDateNode = FocusNode();
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

  Future<List<dynamic>> getFieldSuggestions(String pattern) async {
    try {
      final globalModel = context.read<GlobalModel>();
      return globalModel.getSuggestions(
          '/api/fields', pattern, 'fields', () => Field());
    } catch (err) {
      print('An error occurred while trying to get suggested fields:');
      print(err);
      return [];
    }
  }

  void createField(String value) {
    showDialog(context: context, builder: (_) => CreateFieldDialog(value));
  }

  Widget fieldItemBuilder(BuildContext context, dynamic suggestion) {
    return ListTile(leading: Icon(Icons.list), title: Text((suggestion as Field).name));
  }

  void onFieldSuggestionSelected(
      dynamic selection, TextEditingController controller) {
    controller.text = (selection as Field).abbreviation;
    widget.model.field = selection as Field;
  }

  Future<List<dynamic>> getInstitutionSuggestions(String pattern) async {
    try {
      final globalModel = context.read<GlobalModel>();
      return globalModel.getSuggestions(
          '/api/institutions', pattern, 'institutions', () => Institution());
    } catch (err) {
      print('An error occurred while trying to get suggested institutions:');
      print(err);
      return [];
    }
  }

  void createInstitution(String value) {
    showDialog(
        context: context, builder: (_) => CreateInstitutionDialog(value));
  }

  Widget institutionItemBuilder(BuildContext context, dynamic suggestion) {
    return ListTile(
        leading: Icon(Icons.list),
        title: Text((suggestion as Institution).name),
        subtitle: Text((suggestion as Institution).longName));
  }

  void onInstitutionSuggestionSelected(
      dynamic selection, TextEditingController controller) {
    controller.text = (selection as Institution).name;
    widget.model.institution = selection as Institution;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoComplete(
            autofocus: true,
            itemName: 'Institution',
            decoration: InputDecoration(
                labelText: 'Institution*', border: OutlineInputBorder()),
            initialValue: widget.model.institution?.name,
            validator: (value) {
              if (value.isEmpty) {
                return 'Required';
              }
              return null;
            },
            onEditingComplete: () {
              FocusScope.of(context).requestFocus(majorNode);
            },
            getSuggestions: getInstitutionSuggestions,
            itemBuilder: institutionItemBuilder,
            onSuggestionSelected: onInstitutionSuggestionSelected,
            onNoItemsFound: (String value) {
              createInstitution(value);
            }),
        SizedBox(height: SizeConfig.safeBlockVertical * 2),
        AutoComplete(
            focusNode: majorNode,
            itemName: 'Field',
            decoration: InputDecoration(
                labelText: 'Field of Study*', border: OutlineInputBorder()),
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
            onEditingComplete: () {
              FocusScope.of(context).requestFocus(startDateNode);
            },
            getSuggestions: getFieldSuggestions,
            itemBuilder: fieldItemBuilder,
            onSuggestionSelected: onFieldSuggestionSelected,
            onNoItemsFound: (String value) {
              createField(value);
            }),
        Container(
            margin: EdgeInsets.only(top: 20),
            child: Row(children: [
              Icon(Icons.school),
              Text(
                '  Degree Type*',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              )
            ])),
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
            focusNode: startDateNode,
            firstDate: DateTime(DateTime.now().year - 100),
            lastDate: DateTime(DateTime.now().year + 1, 12, 31),
            initialDate: widget.model.startDate,
            onChanged: (value) {
              widget.model.startDate = value;
            },
            onEditingComplete: () {
              FocusScope.of(context).requestFocus(endDateNode);
            }),
        Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
                _isCurrent ? 'Expected Graduation Date' : 'Graduation Date*',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
        MonthYearPicker(
            focusNode: endDateNode,
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
