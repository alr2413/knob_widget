import 'package:flutter/material.dart';
import 'dart:math';

class AllTickPainter extends CustomPainter {
  final int tickCount;
  final int margin;
  final double width;
  final Color color;

  AllTickPainter({
    this.tickCount = 100,
    this.margin = 10,
    this.width = 1,
    this.color = Colors.grey,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var tickPaint = Paint();
    tickPaint.color = color;
    tickPaint.strokeCap = StrokeCap.round;

    canvas.translate(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    canvas.scale(-1, -1);
    final double rotationDegree = (2 * pi / tickCount);
    double length = 0;
    double width = 0;
    for (int i = 0; i < tickCount; i++) {
      //
      if (i > margin && i < tickCount / 2 + 1) {
        if (i < (tickCount / 2) - 5) {
          length += 0.2;
        }
        double range = (tickCount / 2) + 1 - margin;
        width = width + (1 / range);
        tickPaint.strokeWidth = width;
        canvas.drawLine(
          Offset(0.0, radius + 8),
          Offset(0.0, radius - length),
          tickPaint,
        );
      } else if (i > tickCount / 2 && i < tickCount - margin) {
        if (i > (tickCount / 2) + 5) {
          length -= 0.2;
        }
        double range = (tickCount / 2) + 1 - margin;
        width = width - (1 / range);
        tickPaint.strokeWidth = width;
        canvas.drawLine(
          Offset(0.0, radius + 8),
          Offset(0.0, radius - length),
          tickPaint,
        );
      }
      //
      canvas.rotate(rotationDegree);
    }

    // double length = 10;
    // double rightLength = -9.5;
    // double strokeWidth = 1;
    // double strokeWidthRight = 0;
    //
    // for (int i = 0; i < tickCount; i++) {
    //   if (i > 7 && i < 51) {
    //     length = length - 0.5;
    //
    //     strokeWidth = strokeWidth - (1 / 44);
    //     tickPaint.strokeWidth = strokeWidth;
    //   } else if (i > 50 && i < 94) {
    //     rightLength = rightLength + 0.5;
    //     length = rightLength;
    //
    //     strokeWidthRight = strokeWidthRight + (1 / 44);
    //     tickPaint.strokeWidth = strokeWidthRight;
    //   } else {
    //     tickPaint.strokeWidth = 1;
    //     length = 12;
    //   }
    //
    //   canvas.drawLine(
    //     Offset(0.0, radius + 8),
    //     Offset(0.0, radius - length),
    //     tickPaint,
    //   );
    //
    //   canvas.rotate((2 * pi / tickCount));
    // }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
