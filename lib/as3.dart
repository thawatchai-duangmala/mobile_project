import 'package:flutter/material.dart';

class As3 extends StatefulWidget {
  const As3({super.key});

  @override
  State<As3> createState() => _As3State();
}

class _As3State extends State<As3> {
  int red = 0;
  int green = 0;
  int blue = 0;

  int ColorValue(String value) {
    int? val = int.tryParse(value);
    if (val == null || val < 0) {
      return 0;
    }
    if (val > 255) {
      return 255;
    }
    return val;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('RGB Color Mixing')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    child: TextField(
                      decoration: const InputDecoration(hintText: "Red 0-255"),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          red = ColorValue(value);
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    child: TextField(
                      decoration:
                          const InputDecoration(hintText: "Green 0-255"),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          green = ColorValue(value);
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    child: TextField(
                      decoration: const InputDecoration(hintText: "Blue 0-255"),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          blue = ColorValue(value);
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Column(
              children: [
                const SizedBox(height: 10),
                SizedBox(
                  width: 160,
                  height: 170,
                  child: Container(
                    color:
                        Color.fromRGBO(red, green, blue, 1.0), 
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
