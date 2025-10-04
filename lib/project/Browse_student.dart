import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/project_Mobile/widget/roomcard.dart';

class BrowseStudent extends StatefulWidget {
  const BrowseStudent({super.key});

  @override
  State<BrowseStudent> createState() => _BrowseStudentState();
}

class _BrowseStudentState extends State<BrowseStudent> {
  String url = '172.23.96.1:3000';
  // late กำหนดที่หลัง
  // late List<Map<String, dynamic>> rooms;
  List rooms = [];
  bool isLoading = true;

  void getrooms() async {
    Uri uri = Uri.http(url, '/rooms/browse');
    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      // Map<String,dynamic> data = json.decode(response.body);
      final List<dynamic> jsonData = jsonDecode(response.body);

      setState(() {
        rooms = jsonData;
        debugPrint(rooms[0]['room_name']);
        // rooms = data as dynamic;
        // // debugPrint(data);
        // isLoading = false;
        // for (var item in jsonData) {
        //   print(item); // Prints the entire JSON object as a Map
        // }
      });
    } else {
      throw Exception('Failed to load rooms');
    }
  }

  @override
  void initState() {
    super.initState();
    getrooms();
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
                // data (right side) line43
                final data = rooms[index];
                // debugPrint(data);
                // return Text(data?['room_name']);
                return Roomcard(
                  image: data?['img'],
                  name: data?['room_name'],
                  roomId: data?['room_id'],
                  size: data?['size'],
                  timeSlot1: data?['slot_1'],
                  timeSlot2: data?['slot_2'],
                  timeSlot3: data?['slot_3'],
                  timeSlot4: data?['slot_4'],
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
