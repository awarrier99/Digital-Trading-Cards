import 'package:flutter/material.dart';
import 'package:ui/components/forms/ColorBadge.dart';
import 'package:ui/components/inheritedWidgets/SubFormInheritedWidget.dart';
import 'package:ui/palette.dart';

// The subform is reusable and able to hold form widgets such as
// EducationInputs, PersonalInfoInputs, etc.

// Then the dynamic form can house multiple subform widgets to create a custom
// form

class SubForm extends StatefulWidget {
  final String subTitle;
  final int index;
  final Function callback;
  final subModel;

  SubForm(
      {@required this.subTitle,
      @required this.index,
      @required this.callback,
      this.subModel});

  @override
  _SubFormState createState() => _SubFormState();
}

class _SubFormState extends State<SubForm> {
  @override
  Widget build(BuildContext context) {
    final subFormInherited = SubFormInheritedWidget.of(context);

    return Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                '${widget.subTitle} #${widget.index}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              IconButton(
                icon: Icon(Icons.delete_outline),
                onPressed: () {
                  widget.callback(widget.index - 1);
                },
              ),
            ]),
            subFormInherited.inputBuilder(widget.subModel),
          ],
        ));
  }
}
