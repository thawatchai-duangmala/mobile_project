import 'package:flutter/material.dart';

class RowDemo extends StatelessWidget {
  const RowDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Row Demo'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 100,
            color: Colors.yellow,
          ),
          Container(
            width: 50,
            height: 200,
            color: Colors.red,
          ),
          Container(
            width: 50,
            height: 100,
            color: Colors.blue,
          ),

        ],
      ),
    );
  }
}