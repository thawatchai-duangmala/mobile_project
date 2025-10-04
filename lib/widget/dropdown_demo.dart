import 'package:flutter/material.dart';

class DropdownDemo extends StatefulWidget {
  const DropdownDemo({super.key});

  @override
  State<DropdownDemo> createState() => _DropdownDemoState();
}

class _DropdownDemoState extends State<DropdownDemo> {
  String _year = 'ALL';
  void updateDropdown(String? value) {
    setState(() {
      _year = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton(
              value: _year,
              items: const [
                DropdownMenuItem(
                  value: 'ALL',
                  child: Text('ALL'),
                ),
                DropdownMenuItem(
                  value: '2024',
                  child: Text('2024'),
                ),
                DropdownMenuItem(
                  value: '2023',
                  child: Text('2023'),
                ),
              ],
              onChanged: updateDropdown,
            ),
          ),
          Text('You choose $_year'),
        ],
      ),
    );
  }
}
