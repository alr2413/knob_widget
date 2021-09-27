import 'package:flutter/material.dart';
import 'package:knob_widget/src/utils/control_tick_style.dart';

class ControlStyle {
  final Color backgroundColor;
  final Color shadowColor;
  final Color glowColor;
  final ControlTickStyle tickStyle;

  const ControlStyle({
    this.backgroundColor = Colors.white,
    this.shadowColor = Colors.blueAccent,
    this.glowColor = Colors.blueAccent,
    this.tickStyle = const ControlTickStyle(),
  });
}
