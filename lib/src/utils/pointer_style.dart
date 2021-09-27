import 'package:flutter/material.dart';

class PointerStyle {
  final double width;
  final double height;
  final double offset;
  final Color color;

  const PointerStyle({
    this.width = 10,
    this.height = 10,
    this.offset = 8,
    this.color = Colors.blueAccent,
  });
}
