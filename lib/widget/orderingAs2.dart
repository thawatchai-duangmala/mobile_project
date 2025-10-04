import 'package:flutter/material.dart';

class Orderingas2 extends StatefulWidget {
  const Orderingas2({super.key});

  @override
  State<Orderingas2> createState() => _Orderingas2State();
}

class _Orderingas2State extends State<Orderingas2> {
  // switch
  bool _sw = false;
  void updateSwitch(bool? value) {
    setState(() {
      _sw = value!;
    });
  }

  // radio
  int _gValue = 0;
  void updateRadio(int? value) {
    setState(() {
      _gValue = value!;
    });
  }

  //slider
  double _sl2 = 1;
  void updateslider2(double? value) {
    setState(() {
      _sl2 = value!;
    });
  }
  // ty text
  String showty = '';

  // function showoder
  void _showOrder() async {
    
    String sugarLevel = (_sl2 == 0
        ? 'no'
        : _sl2 == 1
            ? 'less'
            : 'normal');
    String type = (_sw ? 'Cold' : 'Hot');
    String coffeeType = (_gValue == 0
        ? 'Latte'
        : _gValue == 1
            ? 'Americano'
            : 'Cappuccino');
    String price = (_gValue == 0
        ? '35'
        : _gValue == 1
            ? '30'
            : '40');
    String img = '';
    if (_gValue == 0) {
      img =
          _sw ? 'assets/images/cold_latte1.jpg' : 'assets/images/hot_latte.jpg';
    } else if (_gValue == 1) {
      img = _sw
          ? 'assets/images/cold_Americanov1.jpg'
          : 'assets/images/hot_americano.png';
    } else if (_gValue == 2) {
      img = _sw
          ? 'assets/images/cold_cappuccino.png'
          : 'assets/images/hot_cappuccino.jpg';
    }

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Your order'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(img),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text(
                    '$type $coffeeType with $sugarLevel sugar. Price = $price Bath'),
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'Yes');
                    setState(() {
                      showty = 'Thank you for your order';
                    });
                  },
                  child: const Text('Yes'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'no');
                  },
                  child: const Text('No'),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MFU Coffee Shop',
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 8),
              child: Center(
                child: Text(
                  'Your Oder',
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                'Coffee',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              children: [
                Radio(value: 0, groupValue: _gValue, onChanged: updateRadio),
                const Text('Latte 35'),
              ],
            ),
            Row(
              children: [
                Radio(value: 1, groupValue: _gValue, onChanged: updateRadio),
                const Text('Americano 30'),
              ],
            ),
            Row(
              children: [
                Radio(value: 2, groupValue: _gValue, onChanged: updateRadio),
                const Text('Cappuccino 40'),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8, left: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Type',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
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
                  const Text(
                    'Sugar',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text('None'),
                  ),
                  Expanded(
                    child: Slider(
                      value: _sl2,
                      onChanged: updateslider2,
                      min: 0,
                      max: 2,
                      divisions: 2,
                      label: _sl2 == 0
                          ? 'None'
                          : _sl2 == 1
                              ? 'Less'
                              : 'Normal',
                    ),
                  ),
                  const Text('Normal'),
                ],
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    FilledButton(
                      onPressed: _showOrder,
                      child: Text('Order'),
                    ),
                    Text(
                      showty,
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
