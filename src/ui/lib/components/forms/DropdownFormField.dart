import 'package:flutter/material.dart';

class DropdownFormField extends StatefulWidget {
  final List<String> data;
  final String initialValue;
  final Function onChanged;

  DropdownFormField(this.data, {this.onChanged, this.initialValue});
  // DropdownFormField({Key key}) : super(key: key);

  @override
  _DropdownFormFieldState createState() => _DropdownFormFieldState();
}

class _DropdownFormFieldState extends State<DropdownFormField> {
  String dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.initialValue ?? widget.data[0];
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      DropdownButton<String>(
        value: dropdownValue,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 16,
        onChanged: (String newValue) {
          setState(() {
            dropdownValue = newValue;
          });
          if (widget.onChanged != null) widget.onChanged(newValue);
          // widget.onChanged(newValue);
        },
        items: widget.data.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      )
    ]);
  }
}
