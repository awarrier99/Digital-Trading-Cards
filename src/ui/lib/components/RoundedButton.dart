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
      child: InkWell(
        onTap: isThinking ? null : onTapFunction,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 40,
          width: 260,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.8),
                spreadRadius: 2,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
            color: isThinking ? Palette.secondary : color,
          ),
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
