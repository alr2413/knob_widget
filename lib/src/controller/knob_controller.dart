import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:knob_widget/src/helper/angle_helper.dart';
import 'package:knob_widget/src/models/knob_value.dart';

typedef OnValueChangedCallback = void Function(double);

///
/// Controls a knob, and provides updates when the value is changing.
///
class KnobController extends ValueNotifier<KnobValue> {
  /// this function will be triggered whenever the value of knob gets changed
  /// List of onInit listeners
  final List<OnValueChangedCallback> _onValueChangedListeners = [];

  /// initial value of knob must between minimum & maximum
  final double initial;

  /// minimum value of knob
  final double minimum;

  /// maximum value of knob
  final double maximum;

  /// start angle of knob in degree
  final double startAngle;

  /// end angle of knob in degree
  final double endAngle;

  /// Constructs a [KnobController]
  ///
  KnobController({
    this.initial = 0,
    this.minimum = 0,
    this.maximum = 100,
    this.startAngle = 0,
    this.endAngle = 180,
  })  : assert(maximum > minimum,
            'Maximum value must be greater than minimum value.'),
        assert(maximum >= initial && initial >= minimum,
            'Initial value must be between minimum and maximum values.'),
        super(KnobValue(
          current: initial,
          minimum: minimum,
          maximum: maximum,
          startAngle: startAngle,
          endAngle: endAngle,
        ));

  /// Register a [VoidCallback] closure to be called when the controller gets initialized
  void addOnValueChangedListener(OnValueChangedCallback listener) {
    _onValueChangedListeners.add(listener);
  }

  /// Remove a previously registered closure from the list of onInit closures
  void removeOnValueChangedListener(OnValueChangedCallback listener) {
    _onValueChangedListeners.remove(listener);
  }

  ///
  /// set current value of knob & notify all listeners
  /// make sure the value is between the provided min & max
  ///
  void setCurrentValue(double newValue) {
    if (newValue < value.minimum || newValue > value.maximum) {
      return;
    }
    value = value.copyWith(current: newValue);
    for (var listener in _onValueChangedListeners) {
      listener(value.current);
    }
  }

  ///
  /// Return angle of knob in degree corresponding to the provided value
  ///
  double getAngleOfValue(double newValue) {
    var min = AngleHelper.radian(value.startAngle);
    var max = AngleHelper.radian(value.endAngle);
    min = AngleHelper.normalize(min);
    while (min > max) {
      // both min and max are positive and in the correct order.
      max += 2 * math.pi;
    }
    var angle = (max - min) /
            (value.maximum - value.minimum) *
            (newValue - value.minimum) +
        min;
    angle = AngleHelper.normalize(angle - math.pi / 2);
    // while (angle < min) {
    //   // set angle after min angle
    //   angle += 2 * math.pi;
    // }
    return AngleHelper.degree(angle);
  }

  ///
  /// Return value of knob corresponding to the provided angle in radian
  ///
  double getValueOfAngle(double angle) {
    var min = AngleHelper.radian(value.startAngle);
    var max = AngleHelper.radian(value.endAngle);
    min = AngleHelper.normalize(min);
    while (min > max) {
      // both min and max are positive and in the correct order.
      max += 2 * math.pi;
    }
    angle = AngleHelper.normalize(angle + math.pi);
    while (angle < min) {
      // set angle after min angle
      angle += 2 * math.pi;
    }
    if (angle > max) {
      // if angle is out of range because the range is limited set to the closer limit
      if (angle - max > min - angle + math.pi * 2) {
        angle = min;
      } else {
        angle = max;
      }
    }
    return (value.maximum - value.minimum) / (max - min) * (angle - min) +
        value.minimum;
  }

  ///
  /// Check if the provided angle in radian is in valid range
  ///
  bool isInValidRange(double angle) {
    var min = AngleHelper.radian(value.startAngle);
    var max = AngleHelper.radian(value.endAngle);
    min = AngleHelper.normalize(min);
    while (min > max) {
      // both min and max are positive and in the correct order.
      max += 2 * math.pi;
    }
    angle = AngleHelper.normalize(angle + math.pi);
    while (angle < min) {
      // set angle after min angle
      angle += 2 * math.pi;
    }
    return (angle > min && angle < max);
  }
}
