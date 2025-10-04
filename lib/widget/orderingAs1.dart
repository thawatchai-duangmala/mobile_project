import 'package:flutter/material.dart';


class Orderingas1 extends StatefulWidget {
  const Orderingas1({super.key});


  @override
  State<Orderingas1> createState() => _Orderingas1State();
}


class _Orderingas1State extends State<Orderingas1> {
  bool _sw = false;
  double _sl2 = 1;


  // Switch function
  void updateSwitch(bool? value) {
    setState(() {
      _sw = value!;
    });
  }


  // Slider function
  void updateslider2(double? value) {
    setState(() {
      _sl2 = value!;
    });
  }


  // Show order alert
  void _showOrder()async {
    String sugarLevel = (_sl2 == 0? 'no': _sl2 == 1? 'less': 'normal');
    String type = (_sw? 'Cold' : 'Hot');  
 
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Your order'),
          content: Text('$type coffee with $sugarLevel sugar'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MFU Coffee shop',
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        child: Column(
          children: [
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 15),
                child: Text(
                  'Your order',
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8, left: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Type'),
                  Row(
                    children: [
                      const Text('HOT'),
                      Switch(value: _sw, onChanged: updateSwitch),
                      const Text('COLD'),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8, left: 8),
              child: Row(
                children: [
                  const Text('Sugar level'),
                  Expanded(
                    child: Slider(
                      value: _sl2,
                      onChanged: updateslider2,
                      min: 0,
                      max: 2,
                      divisions: 2,
                      label: _sl2 == 0? 'None': _sl2 == 1? 'Less': 'Normal',
                    ),
                  ),
                  const Text('Normal'),
                ],
              ),
            ),
            Padding(
              padding:const EdgeInsets.all(8),
              child: Column(
                children: [
                  FilledButton(
                    onPressed: _showOrder,
                    child:const Text('ORDER'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
