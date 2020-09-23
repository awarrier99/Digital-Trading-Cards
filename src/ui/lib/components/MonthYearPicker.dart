import 'package:flutter/material.dart';

String pad(int num) {
  return num < 10 ? '0$num' : num.toString();
}

class MonthYearPicker extends StatefulWidget {
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime initialDate;
  final Function onChanged;

  MonthYearPicker({
    @required this.firstDate,
    @required this.lastDate,
    this.initialDate,
    @required this.onChanged
  });

  @override
  State<StatefulWidget> createState() => _MonthYearPickerState();
}

class _MonthYearPickerState extends State<MonthYearPicker> {
  DateTime _parseDate(String text) {
    final components = text.split('/');
    return DateTime(int.parse(components[1]), int.parse(components[0]));
  }

  String _validateDate(String text) {
    if (text.isEmpty) return 'Invalid date format (expected mm/yyyy)';

    final isParseableRegExp = new RegExp(r'((?:0[1-9]|1[0-2])/\d{4})');
    final match = isParseableRegExp.firstMatch(text);
    if (match == null) return 'Invalid date format (expected mm/yyyy)';
    
    final isParseable =  match.group(1) == text;
    if (!isParseable) return 'Invalid date format (expected mm/yyyy)';
    
    DateTime selected = _parseDate(text);
    if (selected.isBefore(widget.firstDate))
      return 'Date cannot be before ${pad(widget.firstDate.month)}/${widget.firstDate.year}';
    if (selected.isAfter(widget.lastDate))
      return 'Date cannot be after ${pad(widget.lastDate.month)}/${widget.lastDate.year}';

    return null;
  }

  void handleChanged(value) {
    if (_validateDate(value) == null) widget.onChanged(_parseDate(value));
  }

  @override
  Widget build(BuildContext context) {
    DateTime initial = widget.initialDate ?? DateTime.now();
    String dateString = '${pad(initial.month)}/${initial.year}';
    return TextFormField(
      decoration: InputDecoration(border: OutlineInputBorder()),
      validator: _validateDate,
      keyboardType: TextInputType.datetime,
      initialValue: dateString,
      onChanged: handleChanged,
    );
  }
}
