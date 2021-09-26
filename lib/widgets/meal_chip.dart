import 'package:flutter/material.dart';

class MealChip extends StatelessWidget {
  const MealChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(
        label: Row(
      mainAxisSize: MainAxisSize.min,
      children: [Text(label)],
    ));
  }
}
