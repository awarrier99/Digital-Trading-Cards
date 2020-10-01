import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextInput extends StatelessWidget {
  final String label;
  final String initialValue;
  final FocusNode focusNode;
  final InputDecoration decoration;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final Color cursorColor;
  final bool obscureText;
  final bool autofocus;
  final int maxLines;
  final Function validator;
  final Function onChanged;
  final Function onFieldSubmitted;

  TextInput(
      {this.label,
      this.initialValue = '',
      this.focusNode,
      this.decoration,
      this.keyboardType = TextInputType.text,
      this.textInputAction = TextInputAction.next,
      this.textCapitalization = TextCapitalization.words,
        this.cursorColor,
      this.obscureText = false,
      this.autofocus = false,
        this.maxLines = 1,
      this.validator,
      this.onChanged,
      this.onFieldSubmitted});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        autofocus: autofocus,
        cursorColor: cursorColor,
        focusNode: focusNode,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        decoration: decoration ??
            InputDecoration(
                labelText: label ?? '', border: OutlineInputBorder()),
        textCapitalization: textCapitalization,
        maxLines: maxLines,
        obscureText: obscureText,
        initialValue: initialValue,
        validator: validator,
        onChanged: (value) {
          final cleanValue = value.trim();
          if (onChanged != null) onChanged(cleanValue);
        },
        onFieldSubmitted: (term) {
          if (onFieldSubmitted != null) onFieldSubmitted(term);
        });
  }
}
