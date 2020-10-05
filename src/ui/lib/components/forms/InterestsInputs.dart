import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui/components/AutoComplete.dart';
import 'package:ui/components/CreateInterestDialog.dart';
import 'package:ui/components/TextInput.dart';
import 'package:ui/models/Global.dart';

import '../../models/CardInfo.dart';

class InterestsInputs extends StatefulWidget {
  final UserInterest model;

  InterestsInputs({@required this.model});

  @override
  InterestsInputsState createState() => InterestsInputsState();
}

class InterestsInputsState extends State<InterestsInputs> {
  Future<List<dynamic>> getInterestSuggestions(String pattern) async {
    try {
      final globalModel = context.read<GlobalModel>();
      return globalModel.getSuggestions(
          '/api/interests', pattern, 'interests', () => Interest());
    } catch (err) {
      print('An error occurred while trying to get suggested interests:');
      print(err);
      return [];
    }
  }

  void createInterest(String value) {
    showDialog(context: context, builder: (_) => CreateInterestDialog(value));
  }

  Widget interestItemBuilder(BuildContext context, dynamic suggestion) {
    return ListTile(
        leading: Icon(Icons.list), title: Text((suggestion as Interest).title));
  }

  void onInterestSuggestionSelected(
      dynamic selection, TextEditingController controller) {
    controller.text = (selection as Interest).title;
    widget.model.interest = selection as Interest;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AutoComplete(
            autofocus: true,
            itemName: 'Interest',
            decoration: InputDecoration(
                hintText: 'Title*', border: OutlineInputBorder()),
            textCapitalization: TextCapitalization.sentences,
            initialValue: widget.model.interest?.title,
            validator: (value) {
              if (value.isEmpty) {
                return 'Required';
              }
              return null;
            },
            getSuggestions: getInterestSuggestions,
            itemBuilder: interestItemBuilder,
            onSuggestionSelected: onInterestSuggestionSelected,
            onNoItemsFound: (value) {
              createInterest(value);
            }),
      ],
    );
  }
}
