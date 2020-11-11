import 'package:flutter/material.dart';
import 'package:ui/components/TextInput.dart';

String pad(int num) {
  return num < 10 ? '0$num' : num.toString();
}

// This is a custom date picker widget
class MonthYearPicker extends StatefulWidget {
  final FocusNode focusNode;
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime initialDate;
  final bool isRequired;
  final Function onChanged;
  final Function onEditingComplete;

  MonthYearPicker(
      {this.focusNode,
      @required this.firstDate,
      @required this.lastDate,
      this.initialDate,
      this.isRequired = true,
      @required this.onChanged,
      this.onEditingComplete});

  @override
  State<StatefulWidget> createState() => _MonthYearPickerState();
}

class _MonthYearPickerState extends State<MonthYearPicker> {
  DateTime _parseDate(String text) {
    if (text.isEmpty) return null;
    final components = text.split('/');
    return DateTime(int.parse(components[1]), int.parse(components[0]));
  }

  String _validateDate(String text) {
    if (text.isEmpty) {
      if (!widget.isRequired) return null;
      return 'Invalid date format (expected mm/yyyy)';
    }

    final isParseableRegExp = new RegExp(r'((?:0[1-9]|1[0-2])/\d{4})');
    final match = isParseableRegExp.firstMatch(text);
    if (match == null) return 'Invalid date format (expected mm/yyyy)';

    final isParseable = match.group(1) == text;
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

  void onEditingComplete() {
    if (widget.onEditingComplete != null) widget.onEditingComplete();
  }

  @override
  Widget build(BuildContext context) {
    DateTime initial = widget.initialDate;
    String dateString =
        initial == null ? '' : '${pad(initial.month)}/${initial.year}';
    return TextInput(
      focusNode: widget.focusNode,
      decoration: InputDecoration(border: OutlineInputBorder()),
      validator: _validateDate,
      keyboardType: TextInputType.datetime,
      initialValue: dateString,
      onChanged: handleChanged,
      onEditingComplete: onEditingComplete,
    );
  }
}
