import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui/SizeConfig.dart';
import 'package:ui/components/AutoComplete.dart';
import 'package:ui/components/TextInput.dart';
import 'package:ui/models/Global.dart';

import '../../models/CardInfo.dart';
import '../CreateCompanyDialog.dart';
import '../MonthYearPicker.dart';

// This form widget has input widgets that allows the users to enter in their
// volunteer experience.

class VolunteeringInputs extends StatefulWidget {
  final Volunteering model;

  VolunteeringInputs({@required this.model});

  @override
  VolunteeringInputsState createState() => VolunteeringInputsState();
}

class VolunteeringInputsState extends State<VolunteeringInputs> {
  final FocusNode companyNode = FocusNode();
  final FocusNode descriptionNode = FocusNode();
  final FocusNode startDateNode = FocusNode();
  final FocusNode endDateNode = FocusNode();

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
            label: 'Title*',
            textCapitalization: TextCapitalization.words,
            initialValue: widget.model.title,
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
              widget.model.title = value;
            }),
        SizedBox(height: SizeConfig.safeBlockVertical * 2),
        AutoComplete(
            focusNode: companyNode,
            cursorColor: Color(0xFF92DAAF),
            label: 'Company*',
            itemName: 'Company',
            pluralItemName: 'Companies',
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
            initialDate: widget.model.startDate,
            onChanged: (value) {
              widget.model.startDate = value;
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
            initialDate: widget.model.endDate,
            onChanged: (value) {
              widget.model.endDate = value;
            })
      ],
    );
  }
}
