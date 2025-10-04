import 'package:flutter/material.dart';

class As1 extends StatelessWidget {
  const As1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[200],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            const SizedBox(height: 20),
            const Text(
              'Wedding Organizer',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Sevillana',
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Pre wedding, photo, Party',
              style: TextStyle(
                  color: Colors.white, fontFamily: 'Sevillana', fontSize: 20),
            ),
            // button
            const SizedBox(height: 5),
            ElevatedButton(
              onPressed: null,
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(Colors.red),
              ),
              child: const Text('Our services',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            const Spacer(),
            const Padding(
                padding: EdgeInsets.only(bottom: 9),
                child: Text("345 Moo 1 Tasud Chiang Rai, Thailand",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ))),
          ],
        ),
      ),
    );
  }
}
