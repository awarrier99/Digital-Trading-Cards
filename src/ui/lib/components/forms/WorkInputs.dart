import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui/SizeConfig.dart';
import 'package:ui/components/AutoComplete.dart';
import 'package:ui/components/CreateCompanyDialog.dart';
import 'package:ui/components/TextInput.dart';
import 'package:ui/models/Global.dart';

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
    if (widget.model.startDate == null) {
      widget.model.startDate =
          DateTime(DateTime.now().year, DateTime.now().month);
    }
    if (widget.model.endDate == null) {
      widget.model.endDate =
          DateTime(DateTime.now().year + 1, DateTime.now().month);
    }
  }

  Future<List<dynamic>> getCompanySuggestions(String pattern) async {
    try {
      final globalModel = context.read<GlobalModel>();
      return globalModel.getSuggestions(
          '/api/companies', pattern, 'companies', () => Company());
    } catch (err) {
      print('An error occurred while trying to get suggested companies:');
      print(err);
      return [];
    }
  }

  void createCompany(String value) {
    showDialog(context: context, builder: (_) => CreateCompanyDialog(value));
  }

  Widget companyItemBuilder(BuildContext context, dynamic suggestion) {
    return ListTile(title: Text((suggestion as Company).name));
  }

  void onCompanySuggestionSelected(
      dynamic selection, TextEditingController controller) {
    controller.text = (selection as Company).name;
    widget.model.company = selection as Company;
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
            onEditingComplete: () {
              FocusScope.of(context).requestFocus(companyNode);
            },
            onChanged: (value) {
              widget.model.jobTitle = value;
            }),
        SizedBox(height: SizeConfig.safeBlockVertical * 2),
        AutoComplete(
            focusNode: companyNode,
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
            onEditingComplete: () {
              FocusScope.of(context).requestFocus(descriptionNode);
            },
            getSuggestions: getCompanySuggestions,
            itemBuilder: companyItemBuilder,
            onSuggestionSelected: onCompanySuggestionSelected,
            onNoItemsFound: (value) {
              createCompany(value);
            }),
        SizedBox(height: SizeConfig.safeBlockVertical * 2),
        TextInput(
            focusNode: descriptionNode,
            cursorColor: Color(0xFF92DAAF),
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                labelText: 'Description', border: OutlineInputBorder()),
            textCapitalization: TextCapitalization.sentences,
            maxLines: null,
            initialValue: widget.model.description,
            onChanged: (value) {
              widget.model.description = value;
            },
            onEditingComplete: () {
              FocusScope.of(context).requestFocus(startDateNode);
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
                focusNode: endDateNode,
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
