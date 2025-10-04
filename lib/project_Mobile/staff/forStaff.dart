import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:myapp/project_Mobile/login.dart';
import 'package:myapp/project_Mobile/widget/roomcard_staff.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class forStaff extends StatefulWidget {
  const forStaff({super.key});

  @override
  State<forStaff> createState() => _forStaffState();
}

class _forStaffState extends State<forStaff> {
  String url = '192.168.2.33:3000';
  List rooms = [];
  List history = [];
  bool isLoading = true;
  String username = '';
  String role = '';
  final _formKey = GlobalKey<FormState>();
  String roomName = '';
  String image = '';
  int size = 1;

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

  // function add
  Future<void> addRoom() async {
    const String apiUrl =
        "http://192.168.2.33:3000/addrooms"; // Replace with your API endpoint

    Map<String, dynamic> roomData = {
      "room_name": roomName,
      "slot_1": 1,
      "slot_2": 1,
      "slot_3": 1,
      "slot_4": 1,
      "size": size,
    };
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: json.encode(roomData),
      );

      if (response.statusCode == 201) {
        final responseData = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              "Room added successfully! Room ID: ${responseData['room_id']}"),
          backgroundColor: Colors.green,
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Failed to add room: ${response.body}"),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("An error occurred: $e"),
        backgroundColor: Colors.red,
      ));
    }
  }

  // add room
  void _AddRoom() {
    final TextEditingController _imageController = TextEditingController();
    String? previewImage;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add Room"),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: "Room Name"),
                  validator: (value) => value == null || value.isEmpty
                      ? "Enter a room name"
                      : null,
                  onSaved: (value) => roomName = value!,
                ),
                if (previewImage != null && previewImage!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Image.network(
                      previewImage!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Text(
                        "Invalid Image URL",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                DropdownButtonFormField<int>(
                  value: size,
                  items: const [
                    DropdownMenuItem(value: 1, child: Text("Small (5 People)")),
                    DropdownMenuItem(
                        value: 2, child: Text("Medium (10 People)")),
                    DropdownMenuItem(
                        value: 3, child: Text("Large (20 People)")),
                  ],
                  onChanged: (value) => setState(() => size = value!),
                  decoration: const InputDecoration(labelText: "Room Size"),
                ),
              ],
            ),
          ),
          actions: [
            FilledButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  addRoom();
                  Navigator.of(context).pop();
                }
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.green[700]!),
                padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
              ),
              child: const Text("Add Room"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  late Future<Map<String, dynamic>> slotData;
  Future<Map<String, dynamic>> fetchSlotData() async {
    final url = Uri.parse("http://192.168.2.33:3000/staff/dashboard");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      print("Error: $e");
      return {};
    }
  }


  Future<void> getHistory() async {
  try {
    // Define the API endpoint
    Uri uri = Uri.http(url, '/staff/history');

    print("Request URL: ${uri.toString()}");

    // Send GET request to the API
    final response = await http.get(uri, headers: {
      'Content-Type': 'application/json',
    });

    print("Response Status: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      setState(() {
        history = jsonResponse; // Directly assign the response data
        isLoading = false;
      });

      print("History data fetched successfully!");
    } else if (response.statusCode == 404) {
      print('No booking history found.');
      setState(() {
        history = []; // Set history to an empty list
        isLoading = false;
      });
    } else {
      print('Error fetching history: ${response.statusCode}');
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
          role = data['role'] == '2' ? 'Staff' : 'Staff';
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
    slotData = fetchSlotData();
  }

  @override
  void initState() {
    super.initState();
    getUserData();
    getrooms();
    getHistory();
    slotData = fetchSlotData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Meeting Room',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: _AddRoom, // add btn
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: refreshData, // Refresh data on button click
            ),
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
                icon: Icon(Icons.dashboard),
                text: 'Dashboard',
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
                final data = rooms[index];
                return RoomcardStaff(
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

            // dashboard
            FutureBuilder<Map<String, dynamic>>(
              future: slotData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No data available'));
                } else {
                  final data = snapshot.data!;
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Dashboard',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF5B8DBE),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildSlotBox(
                                      'Free slot',
                                      data['total_free'].toString(),
                                      Colors.green[700]),
                                  _buildSlotBox(
                                      'Pending slot',
                                      data['total_pending'].toString(),
                                      Colors.amber[700]),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildSlotBox(
                                      'Reserved slot',
                                      data['total_reserved'].toString(),
                                      Colors.grey[700]),
                                  _buildSlotBox(
                                      'Disable slot',
                                      data['total_disabled'].toString(),
                                      Colors.red[700]),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 70),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildSummaryRow('Total room:',
                                    data['total_rooms'].toString()),
                                _buildSummaryRow('Total slot:',
                                    data['total_slots'].toString()),
                                _buildSummaryRow('Free slot:',
                                    data['total_free'].toString()),
                                _buildSummaryRow('Pending slot:',
                                    data['total_pending'].toString()),
                                _buildSummaryRow('Disable slot:',
                                    data['total_disabled'].toString()),
                                _buildSummaryRow('Reserved slot:',
                                    data['total_reserved'].toString()),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
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
                                            getStatusText(data['status'] ?? 0),
                                            style: TextStyle(
                                              color: getStatusColor(
                                                  data['status'] ?? 0),
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
                                            'Student:',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(data['student_username']?.toString() ??
                                              '-'),
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
                                          Text(data['approver_username']?.toString() ??
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
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Slot Box Widget
  Widget _buildSlotBox(String title, String count, Color? color) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                count,
                style: const TextStyle(
                  fontSize: 27,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

// Function to Build Individual Info Row
  Widget _buildInfoRow(String label, String value, [Color? valueColor]) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            color: valueColor ?? Colors.black,
            fontWeight:
                valueColor != null ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
