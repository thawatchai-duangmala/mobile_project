import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum TimeSlotState { free, reserved, pending, disabled }

class Roomcard extends StatefulWidget {
  final String name, image;
  final int roomId, size, timeSlot1, timeSlot2, timeSlot3, timeSlot4;

  const Roomcard({
    super.key,
    required this.roomId,
    required this.name,
    required this.size,
    required this.image,
    required this.timeSlot1,
    required this.timeSlot2,
    required this.timeSlot3,
    required this.timeSlot4,
  });

  @override
  State<Roomcard> createState() => _RoomcardState();
}

class _RoomcardState extends State<Roomcard> {
  // Request alert dialog for student
  void reqAlert(String roomName, String timeSlot, int roomId, String slotId,
      int size) async {
    String getRoomSizeDescription(int size) {
      switch (size) {
        case 1:
          return 'Small size (5 People)';
        case 2:
          return 'Medium size (10 People)';
        case 3:
          return 'Large size (20 People)';
        default:
          return 'Unknown size';
      }
    }

    // Show the dialog with room and time slot details
    String? action = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Student request'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Display the image of the room
              Image.network(
                'http://192.168.2.37:3000/public/images/${widget.image}',
                width: 150,
                height: 100,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Room and Time slot information
                  Text('Room Name: $roomName'),
                  Text('Time slot: $timeSlot'),
                  Text('Room Size: ${getRoomSizeDescription(size)}'),
                ],
              ),
            ],
          ),
          actions: [
            // Submit button
            TextButton(
              onPressed: () => Navigator.pop(context, 'Submit'),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(Colors.green),
                foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
              ),
              child: const Text('Submit'),
            ),
            // Cancel button
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(Colors.red),
                foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
              ),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );

    // Handle the response action (Submit or Cancel)
    if (action == 'Submit') {
      int? userId =
          await getUserIdFromSharedPreferences(); // Get the actual user ID

      if (userId == null) {
        print('User is not logged in');
        return; // Handle the case when no user is logged in
      }

      // Prepare the request body
      Map<String, dynamic> requestBody = {
        'user_id': userId, // Use the dynamic userId
        'room_id': roomId,
        'slot_id': slotId,
      };

      try {
        // Make the POST request to the backend
        final response = await http.post(
          Uri.parse('http://192.168.2.37:3000/request'), // API endpoint
          headers: {'Content-Type': 'application/json'},
          body: json.encode(requestBody),
        );

        if (response.statusCode == 200) {
          // Handle success response
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Request Success'),
                content: Text(
                    'Your request for $roomName at $timeSlot has been submitted successfully.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Close'),
                  ),
                ],
              );
            },
          );
        } else {
          // Handle failure response
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Request Failed'),
                content: const Text('You can only book one slot per day.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Close'),
                  ),
                ],
              );
            },
          );
        }
      } catch (e) {
        // Handle network or other errors
        print('Error: $e');
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text(
                  'An error occurred. Please check your network and try again.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ],
            );
          },
        );
      }
    } else {
      // Handle "Cancel" action
      print('Request cancelled');
    }
  }

  // Function to get the userId from shared preferences
  Future<int?> getUserIdFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token'); // Fetch the saved JWT token

    if (token == null) {
      return null; // No token means not logged in
    }

    // Decode the JWT token and extract the user ID
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    return decodedToken['userId']; // Assuming 'userId' is in the decoded token
  }

  // Method to map slot status to TimeSlotState
  TimeSlotState _getTimeSlotState(int status) {
    switch (status) {
      case 1:
        return TimeSlotState.free;
      case 4:
        return TimeSlotState.reserved;
      case 2:
        return TimeSlotState.pending;
      default:
        return TimeSlotState.disabled;
    }
  }

  Widget _buildTimeSlotRow(
      String time, int slotStatus, int roomId, String slotId) {
    TimeSlotState state = _getTimeSlotState(slotStatus);

    Color buttonColor;
    String buttonText;

    switch (state) {
      case TimeSlotState.free:
        buttonColor = Colors.green[700]!;
        buttonText = "free";
        break;
      case TimeSlotState.reserved:
        buttonColor = Colors.grey[700]!;
        buttonText = "reserved";
        break;
      case TimeSlotState.pending:
        buttonColor = Colors.amber[700]!;
        buttonText = "pending";
        break;
      case TimeSlotState.disabled:
      default:
        buttonColor = Colors.red[700]!;
        buttonText = "disabled";
        break;
    }

    return Row(
      children: [
        Text(time),
        const SizedBox(width: 5),
        SizedBox(
          width: 80,
          height: 30,
          child: FilledButton(
            // if free can request to approver
            onPressed: state == TimeSlotState.free
                ? () async {
                    int? userId = await getUserIdFromSharedPreferences();
                    if (userId != null) {
                      reqAlert(widget.name, time, roomId, slotId, widget.size);
                    } else {
                      print('User is not logged in');
                    }
                  }
                : null,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(buttonColor),
              padding: MaterialStateProperty.all(
                  const EdgeInsets.only(right: 8, left: 8)),
            ),
            child:
                Text(buttonText, style: const TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 9,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(right: 5, left: 5, top: 10),
                child: Column(
                  children: [
                    Image.network(
                      "http://192.168.2.37:3000/public/images/${widget.image}",
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(widget.name),
                    ),
                    Builder(builder: (context) {
                      switch (widget.size) {
                        case 1:
                          return const Text('Small size(5 People)');
                        case 2:
                          return const Text('Medium size(10 People)');
                        default:
                          return const Text('Large size(20 People)');
                      }
                    }),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 5),
                    child: _buildTimeSlotRow(
                      '08:00-10:00',
                      widget.timeSlot1,
                      widget.roomId,
                      'slot_1',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 5),
                    child: _buildTimeSlotRow(
                      '10:00-12:00',
                      widget.timeSlot2,
                      widget.roomId,
                      'slot_2',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 5),
                    child: _buildTimeSlotRow(
                      '13:00-15:00',
                      widget.timeSlot3,
                      widget.roomId,
                      'slot_3',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 5),
                    child: _buildTimeSlotRow(
                      '15:00-17:00',
                      widget.timeSlot4,
                      widget.roomId,
                      'slot_4',
                    ),
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
