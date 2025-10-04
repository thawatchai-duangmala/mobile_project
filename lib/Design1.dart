import 'package:flutter/material.dart';

class Design1 extends StatelessWidget {
  const Design1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 100,
            color: Colors.red,
          ),
          Expanded(
            child: Container(
              width: 100,
              color: Colors.teal,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    color: Colors.yellow,
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    color: Colors.green,
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 100,
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}