import 'package:flutter/material.dart';
import 'package:ui/palette.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback onTapFunction;
  final Color color;
  bool isThinking;

  RoundedButton(this.text, this.color, this.onTapFunction, this.isThinking);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isThinking ? Palette.secondary : color,
      shadowColor: isThinking ? Palette.secondary : color,
      elevation: 7,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: isThinking ? null : onTapFunction,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 40,
          width: 260,
          child: Center(
            child: isThinking
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Text(
                    text,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'),
                  ),
          ),
        ),
      ),
    );
  }
}
