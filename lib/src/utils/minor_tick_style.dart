import 'package:flutter/material.dart';

class MinorTickStyle {
  final int length;
  final double thickness;
  final Color color;
  final Color highlightColor;

  const MinorTickStyle({
    this.length = 5,
    this.thickness = 1,
    this.color = Colors.red,
    this.highlightColor = Colors.blue,
  });
}
