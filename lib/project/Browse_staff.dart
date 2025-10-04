import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myapp/project_Mobile/widget/roomcard.dart';

class BrowseStaff extends StatefulWidget {
  const BrowseStaff({super.key});

  @override
  State<BrowseStaff> createState() => _BrowseStudentState();
}

class _BrowseStudentState extends State<BrowseStaff> {
  // late กำหนดที่หลัง
  late Map<int, Map<String, dynamic>> rooms;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    rooms = {
      1: {
        'roomId': '1',
        'image': 'assets/images/TableLargeRoom.png',
        'name': 'Meeting Room1',
        'size': 'Large room(20 People)',
        'slot1': 'free',
        'slot2': 'free',
        'slot3': 'reserved',
        'slot4': 'pending'
      },
      2: {
        'roomId': '2',
        'image': 'assets/images/TableMediumRoom.png',
        'name': 'Meeting Room2',
        'size': 'Medium room(10 People)',
        'slot1': 'reserved',
        'slot2': 'disabled',
        'slot3': 'free',
        'slot4': 'free'
      },
      3: {
        'roomId': '1',
        'image': 'assets/images/TableSmallRoom.png',
        'name': 'Meeting Room3',
        'size': 'Small room(5 People)',
        'slot1': 'free',
        'slot2': 'free',
        'slot3': 'free',
        'slot4': 'free'
      },
      4: {
        'roomId': '1',
        'image': 'assets/images/TableMediumRoom.png',
        'name': 'Meeting Room4',
        'size': 'Medium room(10 People)',
        'slot1': 'disabled',
        'slot2': 'disabled',
        'slot3': 'reserved',
        'slot4': 'free'
      },
      5: {
        'roomId': '1',
        'image': 'assets/images/TableLargeRoom.png',
        'name': 'Meeting Room5',
        'size': 'Large room(20 People)',
        'slot1': 'free',
        'slot2': 'free',
        'slot3': 'free',
        'slot4': 'free'
      },
    };
  }

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
            Tab(icon: Icon(Icons.home), child: Text('Home')),
            Tab(
                icon: Icon(Icons.checklist_rounded),
                child: Text('Check status')),
            Tab(icon: Icon(Icons.person), child: Text('Profile')),
          ],
        ),
        body: TabBarView(
          children: [
            ListView.builder(
              itemCount: rooms.length,
              itemBuilder: (context, index) {
                // like roomId image...(left side) line43
                final key = rooms.keys.elementAt(index);
                // data (right side) line43
                final data = rooms[key];
                return Roomcard(
                  image: data?['image'],
                  name: data?['name'],
                  roomId: data?['roomId'],
                  size: data?['size'],
                  timeSlot1: data?['slot1'],
                  timeSlot2: data?['slot2'],
                  timeSlot3: data?['slot3'],
                  timeSlot4: data?['slot4'],
                );
              },
            ),
            // Placeholder for "Check status" tab
            const Center(child: Text("Check status")),
            // Placeholder for "Profile" tab
            const Center(child: Text("Profile")),
          ],
        ),
      ),
    );
  }
}
