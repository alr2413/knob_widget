class KnobValue {
  final double current;
  final double minimum;
  final double maximum;
  final double startAngle;
  final double endAngle;

  KnobValue({
    this.current = 0,
    this.minimum = 0,
    this.maximum = 120,
    this.startAngle = 0,
    this.endAngle = 180,
  });

  KnobValue copyWith({
    double? current,
    double? minimum,
    double? maximum,
    double? startAngle,
    double? endAngle,
  }) {
    return KnobValue(
      current: current ?? this.current,
      minimum: minimum ?? this.minimum,
      maximum: maximum ?? this.maximum,
      startAngle: startAngle ?? this.startAngle,
      endAngle: endAngle ?? this.endAngle,
    );
  }
}
