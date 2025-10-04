import 'package:flutter/material.dart';

class AlertDemo1 extends StatefulWidget {
  const AlertDemo1({super.key});

  @override
  State<AlertDemo1> createState() => _AlertDemo1State();
}

class _AlertDemo1State extends State<AlertDemo1> {
  String answer = '';

  void showAlert() async {
    String? ans = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Is this a mekk'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/mekk.png',
                  width: 125,
                  height: 125,
                ),
                const Text('mekk'),
              ],
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      // close the dialog
                      Navigator.pop(context, 'Yes');
                    },
                    child: const Text('Yes'),
                  ),
                  TextButton(
                    onPressed: () {
                      // close the dialog
                      Navigator.pop(context, 'no');
                    },
                    child: const Text('No'),
                  ),
                ],
              )
            ],
          );
        });
    if (ans != null) {
      setState(() {
        answer = ans;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  FilledButton(
                    onPressed: showAlert,
                    child: const Text('alert'),
                  ),
                  Text(answer),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
