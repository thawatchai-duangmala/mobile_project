import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum TimeSlotState { free, reserved, pending, disabled }

class RoomcardStaff extends StatefulWidget {
  final String name, image;
  final int roomId, size, timeSlot1, timeSlot2, timeSlot3, timeSlot4;

  const RoomcardStaff({
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
  State<RoomcardStaff> createState() => _RoomcardStaffState();
}

class _RoomcardStaffState extends State<RoomcardStaff> {
  Future<int?> getUserIdFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    if (token == null) {
      return null;
    }

    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    return decodedToken['userId'];
  }

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
            onPressed: () {},
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

  void showSwitchDialog(BuildContext context, int roomId, String oldRoomName, String oldRoomSize) {
  bool? isSwitchEnabled; // Null means the switch was not toggled
  TextEditingController roomNameController = TextEditingController();
  String? selectedRoomSize; // Start with no selection to default to old size

  // Map room size labels to numerical values
  Map<String, int> roomSizeMap = {
    'Small (5 People)': 1,
    'Medium (10 People)': 2,
    'Large (20 People)': 3,
  };

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text('Edit Room'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: roomNameController,
                    decoration: InputDecoration(
                      labelText: 'Room Name (Current: $oldRoomName)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: selectedRoomSize,
                    decoration: InputDecoration(
                      labelText: 'Room Size (Current: $oldRoomSize)',
                      border: OutlineInputBorder(),
                    ),
                    items: roomSizeMap.keys
                        .map((size) => DropdownMenuItem(
                              value: size,
                              child: Text(size),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedRoomSize = value!;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  SwitchListTile(
                    title: Text(
                      isSwitchEnabled == null
                          ? 'Disable/Enable '
                          : (isSwitchEnabled! ? 'Enable' : 'Disable'),
                      style: TextStyle(
                        color: isSwitchEnabled == null
                            ? Colors.grey
                            : (isSwitchEnabled! ? Colors.green : Colors.red),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    value: isSwitchEnabled ?? false, // Default to false if not toggled
                    onChanged: (value) {
                      setState(() {
                        isSwitchEnabled = value;
                      });
                    },
                    activeColor: Colors.green,
                    activeTrackColor: Colors.greenAccent[100],
                    inactiveThumbColor: Colors.red,
                    inactiveTrackColor: Colors.redAccent[100],
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Submit'),
                onPressed: () async {
                  String? roomName =
                      roomNameController.text.trim().isNotEmpty ? roomNameController.text.trim() : null;
                  int? roomSize = selectedRoomSize != null ? roomSizeMap[selectedRoomSize]! : null;

                  // Determine the action based on switch toggle state
                  String? action;
                  if (isSwitchEnabled != null) {
                    action = isSwitchEnabled! ? 'enable' : 'disable';
                  }

                  try {
                    // Make the API call
                    final response = await http.post(
                      Uri.parse('http://192.168.2.37:3000/update-room-details'),
                      headers: {'Content-Type': 'application/json'},
                      body: json.encode({
                        'room_id': roomId,
                        'room_name': roomName,
                        'size': roomSize,
                        'img': null, // Optional, include the image if needed
                        'action': action, // Pass the enable/disable action if toggled
                      }),
                    );

                    // Handle response
                    if (response.statusCode == 200) {
                      final data = json.decode(response.body);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(data['message'])),
                      );
                    } else {
                      final error = json.decode(response.body);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(error['error'] ?? 'Error')),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to connect to the server')),
                    );
                  }

                  // Close the dialog
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    },
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
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.red[700]),
                  onPressed: () {
                    // Determine the old room size label
                    String oldRoomSize = {
                          1: 'Small (5 People)',
                          2: 'Medium (10 People)',
                          3: 'Large (20 People)',
                        }[widget.size] ??
                        'Unknown size';

                    // Call the dialog with all required arguments
                    showSwitchDialog(
                        context, widget.roomId, widget.name, oldRoomSize);
                  },
                ),
              ],
            ),
            Row(
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
                              return Text('Small size(5 People)');
                            case 2:
                              return Text('Medium size(10 People)');
                            default:
                              return Text('Large size(20 People)');
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
          ],
        ),
      ),
    );
  }
}