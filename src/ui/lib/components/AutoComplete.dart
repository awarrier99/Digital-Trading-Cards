import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class AutoComplete extends StatelessWidget {
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
  final Function onEditingComplete;

  final String itemName;
  final String pluralItemName;
  final Icon suggestionIcon;
  final Function getSuggestions;
  final Function itemBuilder;
  final Function onSuggestionSelected;
  final Function onNoItemsFound;

  final TextEditingController _controller = TextEditingController();

  AutoComplete(
      {this.label = '',
      this.initialValue = '',
      this.focusNode,
      this.decoration,
      this.keyboardType = TextInputType.text,
      this.textInputAction = TextInputAction.done,
      this.textCapitalization = TextCapitalization.words,
      this.cursorColor,
      this.obscureText = false,
      this.autofocus = false,
      this.maxLines = 1,
      this.validator,
      this.onChanged,
      this.onEditingComplete,
      @required this.itemName,
      this.pluralItemName,
      this.suggestionIcon,
      @required this.getSuggestions,
      @required this.itemBuilder,
      @required this.onSuggestionSelected,
      this.onNoItemsFound});

  TextFieldConfiguration getConfiguration() {
    _controller.text = initialValue;
    return TextFieldConfiguration(
        controller: _controller,
        focusNode: focusNode,
        decoration: decoration ??
            InputDecoration(labelText: label, border: OutlineInputBorder()),
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        textCapitalization: textCapitalization,
        cursorColor: cursorColor,
        obscureText: obscureText,
        autofocus: autofocus,
        maxLines: maxLines,
        onChanged: (value) {
          final cleanValue = value.trim();
          if (onChanged != null) onChanged(cleanValue);
        },
        onEditingComplete: () {
          if (onEditingComplete != null) onEditingComplete();
        });
  }

  void _onSuggestionSelected(dynamic selection) {
    onSuggestionSelected(selection, _controller);
  }

  Widget _noItemsFoundBuilder(BuildContext context) {
    final plural = pluralItemName ?? '${itemName}s';
    if (onNoItemsFound == null) {
      return ListTile(
        leading: Icon(Icons.report),
        title: Text('No matching ${plural.toLowerCase()} found'),
      );
    }
    return ListTile(
        leading: Icon(Icons.add_circle),
        title: Text('Add $itemName'),
        subtitle: Text('Add new ${itemName.toLowerCase()} to the known list'),
        onTap: () {
          onNoItemsFound(_controller.text);
        });
  }

  @override
  Widget build(BuildContext context) {
    return TypeAheadFormField(
        textFieldConfiguration: getConfiguration(),
        validator: validator,
        suggestionsCallback: getSuggestions,
        itemBuilder: itemBuilder,
        noItemsFoundBuilder: _noItemsFoundBuilder,
        onSuggestionSelected: _onSuggestionSelected);
  }
}
