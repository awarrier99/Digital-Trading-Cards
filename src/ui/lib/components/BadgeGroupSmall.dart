import 'package:flutter/material.dart';
import 'package:ui/components/forms/ColorBadgeSmall.dart';

// This is similar to BadgeGroup, but is shown in a condensed single scrollable
// row.
class BadgeGroupSmall extends StatelessWidget {
  final List<String> items;
  final String badgeType;

  BadgeGroupSmall(this.items, this.badgeType);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Wrap(
        spacing: 7,
        runSpacing: 7,
        direction: Axis.horizontal,
        children: [
          for (var item in items) ColorBadgeSmall(item, badgeType),
        ],
      ),
    );
  }
}
