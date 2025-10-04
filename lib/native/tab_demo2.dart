import 'package:flutter/material.dart';

class TabDemo2 extends StatefulWidget {
  const TabDemo2({super.key});

  @override
  State<TabDemo2> createState() => _TabDemoState();
}

class _TabDemoState extends State<TabDemo2> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tab demo'),
        ),
        bottomNavigationBar: const TabBar(
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
