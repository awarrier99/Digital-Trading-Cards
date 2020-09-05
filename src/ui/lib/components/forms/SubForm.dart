import 'package:flutter/material.dart';
import 'package:ui/components/forms/ColorBadge.dart';
import 'package:ui/components/inheretedwidgets/SubFormInheretedWidget.dart';
import 'package:ui/palette.dart';

class SubForm extends StatefulWidget {
  final String subTitle;
  final int index;
  final Function callback;

  SubForm(this.subTitle, this.index, this.callback);

  @override
  _SubFormState createState() => _SubFormState();
}

class _SubFormState extends State<SubForm> {
  @override
  Widget build(BuildContext context) {
    final subFormInhereted = SubFormInheretedWidget.of(context);

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
                  widget.callback();
                },
              ),
            ]),
            subFormInhereted.inputs,
          ],
        ));
  }
}
