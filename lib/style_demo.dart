import 'package:flutter/material.dart';

class StyleDemo extends StatelessWidget {
  StyleDemo({super.key});

  // style varible
  final myStyle =
      TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Style demo")),
      ),
      body: Column(
        children: [
          Text(
            'First text',
            style: myStyle,
          ),
          Text(
            'Second text',
            style: myStyle,
          ),
        ],
      ),
    );
  }
}
