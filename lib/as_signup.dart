import 'package:flutter/material.dart';

class AsSignup extends StatelessWidget {
  AsSignup({super.key});
  final bgColor = const Color(0xFF202020);
  final fgColor = const Color(0xFFFFBD73);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 3,
            child: Image.asset(
              'assets/images/baking.jpg',
              fit: BoxFit.cover,
              alignment: Alignment.bottomCenter,
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(right: 15,left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('sign in'.toUpperCase(),
                      style: Theme.of(context).textTheme.headlineLarge),
                  Text('sign up'.toUpperCase(),
                      style: Theme.of(context).textTheme.titleLarge),
                ],
              ),
            ),
          ),
          const Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.only(top: 25, right: 15, left: 15),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.alternate_email_outlined,
                        color: Color(0xFFFFBD73),
                      ),
                      hintText: "Email Address",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.lock_open,
                        color: Color(0xFFFFBD73),
                      ),
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 17),
              child: Row(
                children: [
                  Ink(
                    decoration: const ShapeDecoration(
                      shape: CircleBorder(
                        side: BorderSide(color: Colors.grey),
                      ),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.android),
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Ink(
                    decoration: const ShapeDecoration(
                      shape: CircleBorder(side: BorderSide(color: Colors.grey)),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.message),
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.small(
          backgroundColor: const Color(0xFFFFBD73),
          shape: const CircleBorder(),
          onPressed: (){},
          child: const Icon(Icons.arrow_forward, color: Color(0xFF202020)),
          ),
    );
  }
}
