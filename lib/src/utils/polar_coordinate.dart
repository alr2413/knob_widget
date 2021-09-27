import 'dart:math';

import 'dart:ui';

typedef RadialDragStart = Function(PolarCoordinate startCoord);
typedef RadialDragUpdate = Function(PolarCoordinate updateCoord);
typedef RadialDragEnd = Function();

class PolarCoordinate {
  final double angle;
  final double radius;

  PolarCoordinate(this.angle, this.radius);

  factory PolarCoordinate.fromPoints(Point origin, Point point) {
    // Subtract the origin from the point to get the vector from the origin
    // to the point.

    final vectorPoint = point - origin;
    final vector = Offset(
      vectorPoint.x.toDouble(),
      vectorPoint.y.toDouble(),
    );

    // The polar coordinate is the angle the vector forms with the x-axis, and
    // the distance of the vector.
    return PolarCoordinate(
      vector.direction,
      vector.distance,
    );
  }

  @override
  toString() {
    return 'Polar Coordinate: ${radius.toStringAsFixed(2)} at ${(angle / 360).toStringAsFixed(2)}°';
  }
}
