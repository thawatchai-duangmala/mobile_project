import 'package:flutter/material.dart';

class Design2 extends StatelessWidget {
  const Design2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: Text(
          'My Profile',
          style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column (
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://icons.iconarchive.com/icons/iconka/meow/128/cat-hiss-icon.png'),
                radius: 50,
                backgroundColor: Colors.orange,
              ),
            ),
            Divider(
              color: Colors.grey[700],
              height: 45,
            ),
            const Text(
              'Name',
              style: TextStyle(color: Colors.grey),
            ),
            const Text(
              'John Doe',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            const Text(
              'Age',
              style: TextStyle(color: Colors.grey),
            ),
            const Text(
              '25',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            const Row(
              children: [
                Icon(
                  Icons.mail,
                  color: Colors.white,
                ),
                SizedBox(width: 4),
                Text(
                  'abc@test.com',
                  style: TextStyle(color: Colors.white),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}