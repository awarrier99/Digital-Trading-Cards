import 'package:flutter/material.dart';

class ColorBadge extends StatelessWidget {
  final String text;
  final Color color1;
  final Color color2;

  ColorBadge(this.text, this.color1, this.color2);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color1, color2],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: Text(
                text,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                    fontSize: 16),
              ),
            ),
          ],
        ));
  }
}
