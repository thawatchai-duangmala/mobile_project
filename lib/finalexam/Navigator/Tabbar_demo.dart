import 'package:flutter/material.dart';

class TabbarDemo extends StatefulWidget {
  const TabbarDemo({super.key});

  @override
  State<TabbarDemo> createState() => _TabbarDemoState();
}

class _TabbarDemoState extends State<TabbarDemo> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Center(
                child: Text(
              'Tab Demo',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            )),
            backgroundColor: Colors.blue[700],
            bottom: const TabBar(
               labelColor: Colors.white,
              unselectedLabelColor: Colors.white,
              tabs: [
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
                )
              ],
            ),
          ),
          body: TabBarView(children: [
            Container(
              child: Text('Test'),
            ),
            Container(
              child: Text('Test1'),
            ),
            Container(
              child: Text('Test2'),
            ),
          ]),
  ));
  }
}
