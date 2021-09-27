import 'dart:math';

class AngleHelper {
  static double degree(double radian) {
    return radian * 180 / pi;
  }

  static double radian(double degree) {
    return degree * pi / 180;
  }

  static double normalize(double angle) {
    while (angle < 0) {
      angle += 2 * pi;
    }
    while (angle >= 2 * pi) {
      angle -= 2 * pi;
    }
    return angle;
  }
}
