import 'package:flutter/material.dart';

class TabDemo extends StatefulWidget {
  const TabDemo({super.key});

  @override
  State<TabDemo> createState() => _TabDemoState();
}

class _TabDemoState extends State<TabDemo> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tab demo'),
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.home),
                text: 'Home',
              ),
              Tab(
                icon: Icon(Icons.train),
                text: 'Train',
              ),
              Tab(
                icon: Icon(Icons.bike_scooter),
                text: 'Bike',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // put anything can witget ,text
            // first tab
            Container(
              child: Text('Home'),
              color: Colors.amber,
            ),
            // second tab
            Column(
              children: [
                Text('Train'),
                FilledButton(onPressed: () {}, child: Text('OK'))
              ],
            ),
            Text('Bike'),
          ],
        ),
      ),
    );
  }
}
