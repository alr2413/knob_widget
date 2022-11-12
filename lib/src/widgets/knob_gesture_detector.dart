import 'package:flutter/material.dart';
import 'package:knob_widget/src/controller/knob_controller.dart';
import 'package:knob_widget/src/utils/polar_coordinate.dart';
import 'package:knob_widget/src/widgets/control_knob.dart';

import 'package:knob_widget/src/widgets/radial_drag_gesture_detector.dart';
import 'package:provider/provider.dart';

class KnobGestureDetector extends StatefulWidget {
  const KnobGestureDetector({
    Key? key,
  }) : super(key: key);

  @override
  State<KnobGestureDetector> createState() => _KnobGestureDetectorState();
}

class _KnobGestureDetectorState extends State<KnobGestureDetector> {
  _onRadialDragStart(PolarCoordinate coordinate) {}

  _onRadialDragUpdate(PolarCoordinate coordinate) {
    var controller = Provider.of<KnobController>(context, listen: false);
    var angle = coordinate.angle;
    var value = controller.getValueOfAngle(angle);
    controller.setCurrentValue(value);
  }

  onRadialDragEnd() {}

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<KnobController>(context);
    return RadialDragGestureDetector(
      onRadialDragStart: _onRadialDragStart,
      onRadialDragUpdate: _onRadialDragUpdate,
      onRadialDragEnd: onRadialDragEnd,
      child: ControlKnob(
        controller.getAngleOfValue(controller.value.current) / 360,
      ),
    );
  }
}
