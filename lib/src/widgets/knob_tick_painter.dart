import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:knob_widget/src/enums/elements_position.dart';
import 'package:knob_widget/src/utils/major_tick_style.dart';
import 'dart:math';

import 'package:knob_widget/src/utils/minor_tick_style.dart';

class KnobTickPainter extends CustomPainter {
  final double minimum;
  final double maximum;
  final double startAngle;
  final double endAngle;
  final bool showLabels;
  final MinorTickStyle minorTickStyle;
  final MajorTickStyle majorTickStyle;
  final ElementsPosition labelPosition;
  final int minorTicksPerInterval;
  final double tickOffset;
  final double labelOffset;
  final TextStyle? labelStyle;

  //
  final double current;
  final Paint tickPaint;

  KnobTickPainter({
    this.minimum = 0,
    this.maximum = 100,
    this.startAngle = 0,
    this.endAngle = 180,
    this.tickOffset = 0,
    this.labelOffset = 0,
    this.showLabels = true,
    this.majorTickStyle = const MajorTickStyle(),
    this.minorTickStyle = const MinorTickStyle(),
    this.labelPosition = ElementsPosition.outside,
    this.labelStyle,
    this.minorTicksPerInterval = 4,
    this.current = 0.0,
  }) : tickPaint = Paint() {
    tickPaint.strokeWidth = 1.5;
  }

  final _textPainter = TextPainter(textDirection: TextDirection.ltr);

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final radius = width / 2;
    final sweepAngle = endAngle - startAngle;
    final range = maximum - minimum;
    final majorTickCount = sweepAngle ~/ range;
    final majorTickAngle = sweepAngle / majorTickCount;
    final minorTickCount = min(range / majorTickCount, minorTicksPerInterval);
    final minorTickAngle = majorTickAngle / minorTickCount;
    final totalTickCount = sweepAngle / minorTickAngle;
    double rotationAngle = minorTickAngle * pi / 180;
    //
    canvas.translate(size.width / 2, size.height / 2);
    canvas.save();
    //
    canvas.rotate(startAngle * pi / 180 - pi / 2);
    for (int i = 0; i <= totalTickCount; i++) {
      bool isMajor = i % minorTickCount == 0;
      tickPaint.color = isMajor
          ? current >= _getLabel((i * minorTickAngle).toInt())
              ? majorTickStyle.highlightColor
              : majorTickStyle.color
          : current >= _getLabel((i * minorTickAngle).toInt())
              ? minorTickStyle.highlightColor
              : minorTickStyle.color;
      tickPaint.strokeWidth =
          isMajor ? majorTickStyle.thickness : minorTickStyle.thickness;
      final tickLength =
          (isMajor ? majorTickStyle.length : minorTickStyle.length);
      canvas.drawLine(
        Offset(0.0, -tickOffset - radius),
        Offset(0.0, -tickOffset - radius - tickLength),
        tickPaint,
      );
      canvas.rotate(rotationAngle);
    }
    canvas.restore();
    //
    if (showLabels) {
      double labelRadius = radius +
          2 * majorTickStyle.length +
          (labelPosition == ElementsPosition.inside ? -1 : 1) * labelOffset;
      canvas.translate(0, -labelRadius);
      canvas.rotate(startAngle * pi / 180 - pi / 2);
      //
      for (int i = 0; i <= totalTickCount; i++) {
        bool isMajor = i % minorTickCount == 0;
        if (isMajor) {
          _textPainter.text = TextSpan(
            text: _getLabel((i * minorTickAngle).toInt()).toStringAsFixed(0),
            style: labelStyle,
          );
          _textPainter.layout(
            minWidth: 0,
            maxWidth: double.maxFinite,
          );
          canvas.rotate(-(i * rotationAngle + startAngle * pi / 180 - pi / 2));
          _textPainter.paint(
            canvas,
            Offset(
              -_textPainter.width / 2 +
                  labelRadius * sin(startAngle * pi / 180 - pi / 2),
              -_textPainter.height / 2 +
                  labelRadius * (1 - cos(startAngle * pi / 180 - pi / 2)),
            ),
          );
          canvas.rotate(i * rotationAngle + startAngle * pi / 180 - pi / 2);
        }
        //
        canvas.translate(
          labelRadius * sin(rotationAngle),
          labelRadius * (1 - cos(rotationAngle)),
        );
        canvas.rotate(rotationAngle);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  double _getLabel(int index) {
    return (maximum - minimum) / (endAngle - startAngle) * index + minimum;
  }
}
