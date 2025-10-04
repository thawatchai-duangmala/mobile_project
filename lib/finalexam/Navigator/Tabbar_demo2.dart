import 'package:flutter/material.dart';

class TabbarDemo2 extends StatefulWidget {
  const TabbarDemo2({super.key});

  @override
  State<TabbarDemo2> createState() => _TabbarDemo2State();
}

class _TabbarDemo2State extends State<TabbarDemo2> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Center(
                child: Text(
              'Tab Bar1',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            )),
            backgroundColor: Colors.blue[700],
          ),
          bottomNavigationBar: const TabBar(tabs: [
            Tab(
              icon: Icon(Icons.home),
              text: 'Home',
            ),
            Tab(
              icon: Icon(Icons.notifications),
              text: 'Notification',
            ),
            Tab(
              icon: Icon(Icons.person),
              text: 'Profile',
            ),
          ]),
          body: TabBarView(children: [
            Container(
              child: Text('Test'),
            ),
            Container(
              child: Text('Test1'),
            ),
            Container(
              child: Text('Test3'),
            ),
          ]),
        ));
  }
}
