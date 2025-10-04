import 'package:flutter/material.dart';

class As2 extends StatefulWidget {
  As2({super.key});

  @override
  State<As2> createState() => _As2State();
}

class _As2State extends State<As2> {
  String result = "";
  TextEditingController num1 = TextEditingController();
  TextEditingController num2 = TextEditingController();

  // function btn
  // calculate
  void calbtn() {
    if (num1.text.isEmpty || num2.text.isEmpty) {
      setState(() {
        result = "Incorrect input";
      });
    } else {
      int? number1 = int.tryParse(num1.text);
      int? number2 = int.tryParse(num2.text);

      if (number1 == null || number2 == null) {
        setState(() {
          result = "Incorrect input";
        });
      } else {
        setState(() {
          result = "Result= ${number1 + number2}";
        });
      }
    }
  }

  // clear
  void clearbtn() {
    num1.clear();
    num2.clear();
    setState(() {
      result = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(width: 10),
                Flexible(
                    child: TextField(
                  decoration: const InputDecoration(hintText: "First number"),
                  controller: num1,
                )),
                SizedBox(width: 10),
                Text("+"),
                SizedBox(width: 10),
                Flexible(
                  child: TextField(
                    decoration:
                        const InputDecoration(hintText: "Second number"),
                    controller: num2,
                  ),
                ),
              ],
            ),
            // btn
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        calbtn();
                      });
                    },
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.blue)),
                    child: const Text(
                      "Calculate",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      clearbtn();
                    },
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.red)),
                    child: const Text(
                      "Clear",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20), // Space between buttons and result
            Text(
              result,
              style: const TextStyle(
                  color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
