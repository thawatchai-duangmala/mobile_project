import 'package:flutter/material.dart';

class ColumnDemo extends StatelessWidget {
  const ColumnDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Column Demo"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: 50,
            height: 50,
            color: Colors.green,
          ),
           Container(
            width: 100,
            height: 50,
            color: Colors.blue,
          ),
           Container(
            width: 50,
            height: 50,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}