import 'dart:math';

import 'package:flutter/material.dart';
import 'package:knob_widget/src/utils/polar_coordinate.dart';

/// Gesture detector that reports user drags in terms of [PolarCoordinate]s with the
/// origin at the center of the provided [child].
///
/// [PolarCoordinate]s are comprised of an angle and a radius (distance).
///
/// Use [onRadialDragStart], [onRadialDragUpdate], and [onRadialDragEnd] to
/// react to the respective radial drag events.
class RadialDragGestureDetector extends StatefulWidget {
  final RadialDragStart? onRadialDragStart;
  final RadialDragUpdate? onRadialDragUpdate;
  final RadialDragEnd? onRadialDragEnd;
  final Widget? child;

  const RadialDragGestureDetector({
    Key? key,
    this.onRadialDragStart,
    this.onRadialDragUpdate,
    this.onRadialDragEnd,
    this.child,
  }) : super(key: key);

  @override
  State<RadialDragGestureDetector> createState() =>
      _RadialDragGestureDetectorState();
}

class _RadialDragGestureDetectorState extends State<RadialDragGestureDetector> {
  _onPanStart(DragStartDetails details) {
    if (null != widget.onRadialDragStart) {
      final polarCoordinate =
          _polarCoordinateFromGlobalOffset(details.globalPosition);
      widget.onRadialDragStart!(polarCoordinate);
    }
  }

  _onPanUpdate(DragUpdateDetails details) {
    if (null != widget.onRadialDragUpdate) {
      final polarCoordinate =
          _polarCoordinateFromGlobalOffset(details.globalPosition);
      widget.onRadialDragUpdate!(polarCoordinate);
    }
  }

  _onPanEnd(DragEndDetails details) {
    if (null != widget.onRadialDragEnd) {
      widget.onRadialDragEnd!();
    }
  }

  _polarCoordinateFromGlobalOffset(globalOffset) {
    // Convert the user's global touch offset to an offset that is local to
    // this Widget.
    final localTouchOffset =
        (context.findRenderObject() as RenderBox).globalToLocal(globalOffset);

    // Convert the local offset to a Point so that we can do math with it.
    final localTouchPoint = Point(localTouchOffset.dx, localTouchOffset.dy);

    // Create a Point at the center of this Widget to act as the origin.
    final originPoint =
        Point(context.size!.width / 2, context.size!.height / 2);

    return PolarCoordinate.fromPoints(originPoint, localTouchPoint);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: _onPanStart,
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: widget.child,
    );
  }
}
