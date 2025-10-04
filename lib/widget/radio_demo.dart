import 'package:flutter/material.dart';

class RadioDemo extends StatefulWidget {
  const RadioDemo({super.key});

  @override
  State<RadioDemo> createState() => _RadioDemoState();
}

class _RadioDemoState extends State<RadioDemo> {
  int _gValue = 0;

  void updateRadio(int? value){
    setState(() {
      _gValue = value!;
    });
  }

  int _gender = 1;
  void updategender(int? value){
    setState(() {
      _gender = value!;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Radio(value: 0, groupValue: _gValue, onChanged: updateRadio),
              Text('0'),

              Radio(value: 1, groupValue: _gValue, onChanged: updateRadio),
              Text('1'),
              Spacer(),
              Text('You choose $_gValue'),
            ],
          ),
          Row(
            children: [
              Radio(value: 1, groupValue: _gender, onChanged: updategender),
              Text('Female'),

              Radio(value: 2, groupValue: _gender, onChanged: updategender),
              Text('Male'),
              Spacer(),
              Text('You choose ${_gender == 1?'Female' : 'Male'}'),
            ],
          )
        ],
      ),
    );
  }
}