import 'package:flutter/material.dart';

class AlertDemo extends StatefulWidget {
  const AlertDemo({super.key});

  @override
  State<AlertDemo> createState() => _AlertDemoState();
}

class _AlertDemoState extends State<AlertDemo> {
  void showAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Alert Title'),
            content: const Text('Alert content'),
            actions: [
              Row(
                children: [
                  // TextButton(
                  //   onPressed: () {
                  //     // close the dialog
                  //     Navigator.pop(context);
                  //   },
                  //   child: const Text('cancel'),
                  // ),

                  TextButton(
                    onPressed: () {
                      // close the dialog
                      Navigator.pop(context);
                    },
                    child: const Text('cancel'),
                  ),
                ],
              )
            ],
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FilledButton(
                onPressed: showAlert,
                child: const Text('alert'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
