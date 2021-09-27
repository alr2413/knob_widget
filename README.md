# Flutter Knob Widget

The missing Knob widget for flutter

<div align="center">
  <img src="https://raw.githubusercontent.com/alr2413/knob_widget/master/doc/knob.jpg" height="400">
</div>

<br>

## Let's get started

To start using the plugin, copy this code or follow the example project in 'knob_widget/example'

```dart
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:knob_widget/knob_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Knob Demo',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: MyHomePage(title: 'Flutter Knob Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final double _minimum = 10;
  final double _maximum = 40;

  late KnobController _controller;
  late double _knobValue;

  void valueChangedListener(double value) {
    if (mounted) {
      setState(() {
        _knobValue = value;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _knobValue = _minimum;
    _controller = KnobController(
      initial: _knobValue,
      minimum: _minimum,
      maximum: _maximum,
      startAngle: 0,
      endAngle: 180,
    );
    _controller.addOnValueChangedListener(valueChangedListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(_knobValue.toString()),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                var value =
                    Random().nextDouble() * (_maximum - _minimum) + _minimum;
                _controller.setCurrentValue(value);
              },
              child: const Text('Update Knob Value'),
            ),
            const SizedBox(height: 75),
            Container(
              child: Knob(
                controller: _controller,
                width: 200,
                height: 200,
                style: KnobStyle(
                  labelStyle: Theme.of(context).textTheme.bodyText1,
                  tickOffset: 5,
                  labelOffset: 10,
                  minorTicksPerInterval: 5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.removeOnValueChangedListener(valueChangedListener);
    super.dispose();
  }
}
```
<br>

## Contributing

There are couple of ways in which you can contribute.
- Propose any feature, enhancement
- Report & Fix a bug
- Write and improve some **documentation**.
- Send in a Pull Request :-)

## License

* The 3-Clause BSD License