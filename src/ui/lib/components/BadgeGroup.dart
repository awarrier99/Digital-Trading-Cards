import 'package:flutter/material.dart';
import 'package:ui/components/forms/ColorBadge.dart';

class BadgeGroup extends StatelessWidget {
  final List<String> items;
  final String badgeType;
  final double fontSize;

  BadgeGroup(this.items, this.badgeType, {this.fontSize = 16});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Wrap(
        spacing: 7,
        runSpacing: 7,
        direction: Axis.horizontal,
        children: [
          for (var item in items)
            ColorBadge(item, badgeType, fontSize: fontSize),
        ],
      ),
    );
  }
}
