import 'package:flutter/material.dart';

class CheckboxDemo extends StatefulWidget {
  const CheckboxDemo({super.key});

  @override
  State<CheckboxDemo> createState() => _CheckboxDemoState();
}

class _CheckboxDemoState extends State<CheckboxDemo> {
  bool cb = false;
  bool sw = false;
  double sliderValue1 = 0.5;
  int _gvalue = 0;
  String result = '';

  void toggleCheckbox(bool? status) {
    setState(() {
      cb = status!;
    });
  }

  void toggleSwitch(bool? status) {
    setState(() {
      sw = status!;
    });
  }

  void updateRadio(int? value) {
    setState(() {
      _gvalue = value ?? 0;
      if (_gvalue == 0) {
        result = 'Ronaldo';
      } else {
        result = 'Messi';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Widjet Demo',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(3),
        child: Column(
          children: [
            // Check box
            Column(
              children: [
                Checkbox(value: cb, onChanged: toggleCheckbox),
                Text('Checkbox: $cb'),
              ],
            ),
            // switch
            Container(
              child: Switch(value: sw, onChanged: toggleSwitch),
            ),
            Text('Switch: $sw'),
            // Slider
            Container(
              child: Slider(
                  value: sliderValue1,
                  divisions: 5,
                  label: sliderValue1.toString(),
                  onChanged: (value) {
                    setState(() {
                      sliderValue1 = value;
                    });
                  }),
            ),
            Text('Slider: $sliderValue1'),
            // raido
            Row(
              children: [
                Radio(value: 0, groupValue: _gvalue, onChanged: updateRadio),
                const Text('Ronaldo'),
                Radio(value: 1, groupValue: _gvalue, onChanged: updateRadio),
                const Text('Messi'),
              ],
            ),
            Text('Radio: $_gvalue'),
            Text('Slect player: $result'),
          ],
        ),
      ),
    );
  }
}
