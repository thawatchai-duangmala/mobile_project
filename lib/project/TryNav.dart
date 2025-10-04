import 'package:flutter/material.dart';

class Trynav extends StatefulWidget {
  const Trynav({super.key});

  @override
  State<Trynav> createState() => _TrynavState();
}

class _TrynavState extends State<Trynav> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Browse list room',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color(0xFF5B8DBE),
        ),
        bottomNavigationBar: const TabBar(
          tabs: [
            Tab(
              icon: Icon(
                Icons.home,
              ),
              child: Text('Home'),
            ),
            Tab(
              icon: Icon(
                Icons.checklist_rounded,
              ),
              child: Text('Check status'),
            ),
            Tab(
              icon: Icon(
                Icons.person,
              ),
              child: Text('Profile'),
            ),
          ],
        ),
        body: TabBarView(
          children: [
            const Column(),
            // tap 2 check status
            const Column(),
            // tap 3 profile and history
            const Column()
          ],
        ),
      ),
    );
  }
}