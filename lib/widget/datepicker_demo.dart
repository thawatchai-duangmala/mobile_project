import 'package:flutter/material.dart';

class DatepickerDemo extends StatefulWidget {
  const DatepickerDemo({super.key});

  @override
  State<DatepickerDemo> createState() => _DatepickerDemoState();
}

class _DatepickerDemoState extends State<DatepickerDemo> {
  String _date = '';
  void selectDate() async {
    DateTime? dt = await showDatePicker(
      context: context,
      firstDate: DateTime(2024, 1, 1),
      lastDate: DateTime(2024, 12, 31),
    );
    if (dt != null) {
      setState(() {
        _date = '${dt.day}-${dt.month}-${dt.year}';
      });
    }
  }

  String _time = '';
  void selectTime() async {
    TimeOfDay? td = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if(td != null){
      setState(() {
        _time = '${td.hour}-${td.minute}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              FilledButton.icon(
                onPressed: selectDate,
                label: const Text('Select date'),
                icon: const Icon(Icons.edit_calendar),
              ),
              Text('You select $_date'),
              
              FilledButton.icon(
                onPressed: selectTime,
                label: const Text('Select Time'),
                icon: const Icon(Icons.edit_calendar),
              ),
              Text('You select $_time'),
            ],
          ),
        ),
      ),
    );
  }
}
