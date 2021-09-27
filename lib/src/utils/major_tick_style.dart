import 'package:flutter/material.dart';

class MajorTickStyle {
  final int length;
  final double thickness;
  final Color color;
  final Color highlightColor;

  const MajorTickStyle({
    this.length = 15,
    this.thickness = 1,
    this.color = Colors.red,
    this.highlightColor = Colors.blue,
  });
}
