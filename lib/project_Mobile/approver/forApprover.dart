import 'dart:convert';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:myapp/project_Mobile/login.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/project_Mobile/widget/roomcard_aprrover.dart';
import 'package:shared_preferences/shared_preferences.dart';

class forApprover extends StatefulWidget {
  const forApprover({super.key});

  @override
  State<forApprover> createState() => _forApproverState();
}

class _forApproverState extends State<forApprover> {
  String url = '192.168.2.33:3000';
  late final String formattedDate; // Use late final
  List rooms = [];
  bool isLoading = true;
  String username = '';
  String role = '';
  List history = [];

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

  // Make roomRequests non-final
  List<Map<String, String>> roomRequests = [];

  Future<void> getBookings() async {
  try {
    Uri uri = Uri.http(url, '/bookings'); // Connect to the '/bookings' route
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List bookingData =
          jsonDecode(response.body); // Parse the response body
      setState(() {
        roomRequests = bookingData
            .map((booking) {
              String timeSlot;
              String roomSize;
              String roomImage;

              // Map slot_id to time ranges
              switch (booking['slot_id']) {
                case 'slot_1':
                  timeSlot = '08:00 - 10:00';
                  break;
                case 'slot_2':
                  timeSlot = '10:00 - 12:00';
                  break;
                case 'slot_3':
                  timeSlot = '13:00 - 15:00';
                  break;
                case 'slot_4':
                  timeSlot = '15:00 - 17:00';
                  break;
                default:
                  timeSlot =
                      'Unknown'; // Default case in case of unrecognized slot_id
                  break;
              }

              // Set room size and image based on the room_size value
              switch (booking['room_size']) {
                case 1:
                  roomSize = 'Small';
                  roomImage = 'assets/images/TableSmallRoom.png';
                  break;
                case 2:
                  roomSize = 'Medium';
                  roomImage = 'assets/images/TableMediumRoom.png';
                  break;
                case 3:
                  roomSize = 'Large';
                  roomImage = 'assets/images/TableLargeRoom.png';
                  break;
                default:
                  roomSize =
                      'Unknown'; // Default room size in case of unrecognized value
                  roomImage =
                      'assets/images/TableLargeRoom.png'; // Fallback image
                  break;
              }

              // Include the new username field along with user_id in the returned data
              return {
                'image': roomImage,
                'roomName': booking['room_name'].toString(),
                'roomSize': roomSize,
                'timeSlot': timeSlot,
                'status': booking['status'] == 2 ? 'Pending' : 'Approved',
                'bookingId': booking['booking_id']
                    .toString(), // Ensure bookingId is included
                'slot_id': booking['slot_id']
                    .toString(), // Ensure slot_id is included
                'room_id': booking['room_id']
                    .toString(), // Ensure room_id is included
                'user_id': booking['user_id']
                    .toString(), // Include user_id here
                'username': booking['user_username']
                    .toString(), // Include username here
              };
            })
            .toList()
            .cast<Map<String, String>>(); // Cast each element to Map<String, String>
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load bookings');
    }
  } catch (e) {
    print("Error: $e");
    setState(() {
      isLoading = false;
    });
  }
}



  Future<String?> getCurrentUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs
        .getString('userId'); // Retrieve the user_id from SharedPreferences
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

  Future<void> _approveOrDisapproveBooking(
      BuildContext context, Map<String, String> request, int index,
      {required bool approve}) async {
    // Logging request data for debugging
    print('Request data: $request');

    // Ensure the request data is valid
    if (request['bookingId'] == null ||
        request['slot_id'] == null ||
        request['room_id'] == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Missing bookingId, slot_id, or room_id')));
      return;
    }

    // Get the current user ID from SharedPreferences (using JWT token)
    String? userId = await getUserIdFromToken();

    // If the user ID is not found, show an error
    if (userId == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('User not logged in')));
      return;
    }

    // Log the approver ID for debugging purposes
    print('Approver ID: $userId');

    // Prepare the request body with actual approverId
    final url = Uri.parse('http://192.168.2.33:3000/approver/approve');
    final requestBody = {
      'bookingId': request['bookingId'],
      'approverId': userId, // Use the actual user_id here
      'approve': approve,
      'slot_id': request['slot_id'],
      'room_id': request['room_id'],
    };

    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        print(responseBody['message']);

        // Update UI after approval/disapproval
        setState(() {
          roomRequests.removeAt(index);
        });
        Navigator.pop(context); // Close the dialog
      } else {
        // Handle failure
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to approve or disapprove')));
      }
    } catch (e) {
      print('Request failed: $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Request failed: $e')));
    }
  }

  Future<String?> getUserIdFromToken() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');

      if (token == null) {
        print('No token found');
        return null;
      }

      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      int? userId = decodedToken['userId'];

      if (userId == null) {
        print('User ID not found in token');
        return null;
      }

      return userId.toString();
    } catch (e) {
      print('Error retrieving user ID from token: $e');
      return null;
    }
  }

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
    print("Decoded Token: $decodedToken");

    String? role = decodedToken['role']?.toString();
    String? approvedBy = decodedToken['userId']?.toString();

    print("Decoded role: $role");
    print("Decoded approved_by: $approvedBy");

    if (approvedBy == null) {
      print("Missing approved_by");
      setState(() {
        isLoading = false;
      });
      return;
    }

    Uri uri = Uri.http(url, '/approver/history', {
      'role': role,
      'approved_by': approvedBy,
    });

    print("Request URL: ${uri.toString()}");

    final response = await http.get(uri, headers: {
      'Authorization': 'Bearer $token',
    });

    print("Response Status: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      // Extract the 'data' field which contains the list
      setState(() {
        history = jsonResponse['data'];
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
          role = data['role'] == '1' ? 'Student' : 'Student';
          role = data['role'] == '2' ? 'Staff' : 'Student';
          role = data['role'] == '3' ? 'Approver' : 'Student';
        });
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  Future<void> refreshData() async {
    setState(() {
      isLoading = true;
    });
    await getrooms();
    await getBookings();
    slotData = fetchSlotData();
    await getHistory();

    // await getHistory();
  }

  @override
  void initState() {
    super.initState();
    slotData = fetchSlotData();
    formattedDate =
        DateFormat('dd/MM/yyyy').format(DateTime.now()); // Initialize here
    getBookings();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
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
                text: 'Status',
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
                // like roomId image...(left side) line43
                // data (right side) line43
                final data = rooms[index];
                // debugPrint(data);
                // return Text(data?['room_name']);
                return RoomcardAprrover(
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
                  const Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      'Approve or Disapprove',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 142, 172, 205),
                      ),
                    ),
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: roomRequests.length,
                    itemBuilder: (context, index) {
                      final request = roomRequests[index];
                      return GestureDetector(
                        onTap: () => _showPopupCard(context, request, index),
                        child: Card(
                          shadowColor: Colors.grey,
                          color: const Color.fromARGB(217, 217, 217, 217),
                          margin: const EdgeInsets.only(bottom: 16.0),
                          child: Row(
                            children: [
                              // Room Image
                              Container(
                                width: 100,
                                height: 100,
                                child: Image.asset(
                                  request['image']!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              // Room Details
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Room Name: ${request['roomName']}',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Room Size: ${request['roomSize']}',
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Student: ${request['username']}',
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 18, vertical: 3),
                                            decoration: BoxDecoration(
                                              color: Colors.amber[700],
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: const Text(
                                              'Pending',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            request['timeSlot']!,
                                            style:
                                                const TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // dashboard Tab
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),

                  // Log Out Button
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Login()),
                            );
                            setState(() {});
                          },
                          icon: const Icon(Icons.logout, color: Colors.white),
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
                                horizontal: 20, vertical: 12),
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

  void _showPopupCard(
    BuildContext context,
    Map<String, String> request,
    int index,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Display room details here
              Container(
                width: 257,
                height: 184,
                child: Image.asset(
                  request['image']!,
                  fit: BoxFit.cover,
                ),
              ),
              Text('Room Name: ${request['roomName']}'),
              Text('Room Size: ${request['roomSize']}'),
              Text('Student: ${request['username']}'),
              Text(
                'Date: $formattedDate', // Display the dynamic date here
                style: const TextStyle(fontSize: 14),
              ),
              Text('Time Slot: ${request['timeSlot']}'),
            ],
          ),
          actions: [
            // Centered buttons for Approve and Disapprove actions
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () async {
                    // Handle Approve action here
                    await _approveOrDisapproveBooking(
                      context,
                      request,
                      index,
                      approve: true,
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor:
                        Colors.green, // Green background for Approve
                  ),
                  child: const Text(
                    'Approve',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 20), // Add some spacing between buttons
                TextButton(
                  onPressed: () async {
                    // Handle Disapprove action here
                    await _approveOrDisapproveBooking(
                      context,
                      request,
                      index,
                      approve: false,
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor:
                        Colors.red, // Red background for Disapprove
                  ),
                  child: const Text(
                    'Disapprove',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        );
      },
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