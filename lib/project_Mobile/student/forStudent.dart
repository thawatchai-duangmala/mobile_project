import 'dart:convert';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:myapp/project_Mobile/login.dart';
import 'package:myapp/project_Mobile/widget/roomcard.dart';
import 'package:myapp/project_Mobile/widget/roomcard_staff.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class forStudent extends StatefulWidget {
  const forStudent({super.key});

  @override
  State<forStudent> createState() => _forStudentState();
}

class _forStudentState extends State<forStudent> {
  String url = '192.168.2.33:3000';
  List rooms = [];
  List history = [];
  bool isLoading = true;
  String username = '';
  String role = '';

  // Time Slot Formatter
  String getTimeRange(String slotId) {
    switch (slotId) {
      case 'slot_1':
        return '08:00 - 10:00';
      case 'slot_2':
        return '10:00 - 12:00';
      case 'slot_3':
        return '13:00 - 15:00';
      case 'slot_4':
        return '15:00 - 17:00';
      default:
        return 'N/A';
    }
  }

  String getStatusText(int status) {
    switch (status) {
      case 1:
        return 'Approved';
      case 2:
        return 'Pending';
      case 3:
        return 'Disapproved';
      default:
        return 'Unknown';
    }
  }

  Color getStatusColor(int status) {
    switch (status) {
      case 1:
        return Colors.green;
      case 2:
        return Colors.amber;
      case 3:
        return Colors.red;
      default:
        return Colors.black;
    }
  }

  // Get Rooms
  Future<void> getrooms() async {
    try {
      Uri uri = Uri.http(url, '/rooms/browse');
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        setState(() {
          rooms = jsonDecode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load rooms');
      }
    } catch (e) {
      print("Error: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  // Get History
  Future<void> getHistory() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');

      if (token == null) {
        print('No token found');
        setState(() {
          isLoading = false;
        });
        return;
      }

      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      int? userId = decodedToken['userId'];

      if (userId == null) {
        setState(() {
          isLoading = false;
        });
        return;
      }

      Uri uri = Uri.http(url, '/student/history', {
        'role': '1',
        'userId': userId.toString(),
      });

      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        setState(() {
          history = jsonDecode(response.body);
          isLoading = false;
        });
      } else if (response.statusCode == 403) {
        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching history: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  void getUserData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');
      if (token == null) return;

      Uri uri = Uri.http(url, '/user/profile');
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          username = data['username'] ?? 'Unknown';
          role = data['role'] == '1' ? 'Student' : 'Student';
        });
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  // Refresh function to update data
  Future<void> refreshData() async {
    setState(() {
      isLoading = true;
    });
    await getrooms();
    await getHistory();
  }

  @override
  void initState() {
    super.initState();
    getUserData();
    getrooms();
    getHistory();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Meeting Room',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )),
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: refreshData, // Refresh data on button click
            )
          ],
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 142, 172, 205),
          toolbarHeight: 51,
        ),
        bottomNavigationBar: Container(
          color: const Color.fromARGB(255, 142, 172, 205),
          child: const TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black54,
            tabs: [
              Tab(
                icon: Icon(Icons.home),
                text: 'Home',
              ),
              Tab(
                icon: Icon(Icons.schedule),
                text: 'Check Status',
              ),
              Tab(
                icon: Icon(Icons.person),
                text: 'Profile',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Home Tab
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

            // Requests Tab
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Requests Tab wrapped in a Card
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'Status',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Check if history is loading or empty
                      if (isLoading)
                        const Center(child: CircularProgressIndicator())
                      else if (history.isEmpty)
                        const Center(child: Text('No request found.'))
                      else
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: history.length,
                          itemBuilder: (context, index) {
                            final data = history[index];
                            if (data['status'] != 2)
                              return SizedBox(); // Only show if status is 'pending' (assuming 2 is pending)
                            return Container(
                              padding: const EdgeInsets.all(16.0),
                              child: Card(
                                elevation: 4.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            data['size'] == 1
                                                ? 'assets/images/TableSmallRoom.png'
                                                : (data['size'] == 2
                                                    ? 'assets/images/TableMediumRoom.png'
                                                    : 'assets/images/TableLargeRoom.png'),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Time:',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(getTimeRange(data['slot_id']
                                                  ?.toString() ??
                                              'N/A')), // Use helper function here
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Room:',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(data['room_name']?.toString() ??
                                              'N/A'),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Room size:',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            (data['size'] == 1)
                                                ? 'Small'
                                                : (data['size'] == 2)
                                                    ? 'Medium'
                                                    : (data['size'] == 3)
                                                        ? 'Large'
                                                        : 'N/A',
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Status:',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            getStatusText(data['status'] ??
                                                0), // Convert status code to text
                                            style: TextStyle(
                                              color: getStatusColor(data[
                                                      'status'] ??
                                                  0), // Set color based on status
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                    ],
                  ),
                ],
              ),
            ),

            // Profile Tab
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),

                  // Log Out Button
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 16.0), // Adjusts horizontal position
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () async {
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Login(),
                                ));
                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.logout,
                            color: Colors.white,
                          ),
                          label: const Text(
                            'Log Out',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[700],
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 5,
                          ),
                        ),
                      ],
                    ),
                  ),

                  //Name
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              username, // Display the fetched username
                              style: const TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "username: $username", // Display the username label
                              style: const TextStyle(fontSize: 17),
                            ),
                            Text(
                              role, // Display the fetched role
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  // Line under name and role
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Divider(
                      color: Colors.black54,
                      thickness: 1.0,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // History Tab
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'History',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Check if history is loading or empty
                      if (isLoading)
                        const Center(child: CircularProgressIndicator())
                      else if (history.isEmpty)
                        const Center(child: Text('No history found.'))
                      else
                        // Displaying the history dynamically
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: history.length,
                          itemBuilder: (context, index) {
                            final data = history[index];
                            return Container(
                              padding: const EdgeInsets.all(16.0),
                              child: Card(
                                elevation: 4.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Time:',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(getTimeRange(data['slot_id']
                                                  ?.toString() ??
                                              'N/A')), // Use helper function here
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Room:',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(data['room_name']?.toString() ??
                                              'N/A'),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Status:',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            getStatusText(data['status'] ??
                                                0), // Convert status code to text
                                            style: TextStyle(
                                              color: getStatusColor(data[
                                                      'status'] ??
                                                  0), // Set color based on status
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Approver:',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                              data['approved_by']?.toString() ??
                                                  '-'),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}