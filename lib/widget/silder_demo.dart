import 'package:flutter/material.dart';

class SilderDemo extends StatefulWidget {
  const SilderDemo({super.key});

  @override
  State<SilderDemo> createState() => _SilderDemoState();
}

class _SilderDemoState extends State<SilderDemo> {
  double _sl = 0.5;
  double _sl2 = 0.0;

  void updateslider(double? value) {
    setState(() {
      _sl = value!;
    });
  }

  void updateslider2(double? value) {
    setState(() {
      _sl2 = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('default Slider: ${_sl.toStringAsFixed(2)}'),
          Slider(
            value: _sl,
            onChanged: updateslider,
            divisions: 10,
            label: _sl.toStringAsFixed(2),
          ),
          const Text('Custom Slider'),
          Slider(
            value: _sl2,
            onChanged: updateslider2,
            min: 0,
            max: 100,
            divisions: 5,
            label: _sl2.round().toString(),
          )
        ],
      ),
    );
  }
}
