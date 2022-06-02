import 'package:flutter/material.dart';
import 'package:knob_widget/src/controller/knob_controller.dart';
import 'package:knob_widget/src/utils/knob_style.dart';
import 'package:provider/provider.dart';

import 'knob_gesture_detector.dart';
import 'knob_tick_painter.dart';

class ControlKnobContainer extends StatefulWidget {
  final double? width;
  final double? height;

  const ControlKnobContainer({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  _ControlKnobContainerState createState() => _ControlKnobContainerState();
}

class _ControlKnobContainerState extends State<ControlKnobContainer> {
  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<KnobController>(context);
    var style = Provider.of<KnobStyle>(context);
    return Container(
      // padding: EdgeInsets.all(
      //   style.majorTickStyle.length.toDouble() +
      //       2 * style.majorTickStyle.length +
      //       max(style.labelOffset, style.tickOffset),
      // ),
      child: Stack(
        children: <Widget>[
          Container(
            width: widget.width,
            height: widget.height,
            color: Colors.transparent,
            child: const KnobGestureDetector(),
          ),
          IgnorePointer(
            child: Container(
              width: widget.width,
              height: widget.height,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
              ),
              child: CustomPaint(
                painter: KnobTickPainter(
                  current: controller.value.current,
                  minimum: controller.value.minimum,
                  maximum: controller.value.maximum,
                  startAngle: controller.value.startAngle,
                  endAngle: controller.value.endAngle,
                  tickOffset: style.tickOffset,
                  labelOffset: style.labelOffset,
                  minorTicksPerInterval: style.minorTicksPerInterval,
                  labelStyle: style.labelStyle,
                  minorTickStyle: style.minorTickStyle,
                  majorTickStyle: style.majorTickStyle,
                  showMinorTickLabels: style.showMinorTickLabels,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
