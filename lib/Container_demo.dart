import 'package:flutter/material.dart';

class ContainerDemo extends StatelessWidget {
  const ContainerDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Container demo'),
      ),
      body: Container(
        width: 200,
        height: 200,
        color: Colors.yellow,
        padding: EdgeInsets.only(left:5, top: 5),
        margin: EdgeInsets.only(left: 10),
        alignment: Alignment.center,
        child: Container(
          width: 50,
          height: 50,
          color: Colors.blue,
          child: Text('Hi'),
          alignment: Alignment.center,
        ),
      ),
    );
  }
}