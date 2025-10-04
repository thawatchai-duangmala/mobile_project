import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum TimeSlotState { free, reserved, pending, disabled }

class RoomcardAprrover extends StatefulWidget {
  final String name, image;
  final int roomId, size, timeSlot1, timeSlot2, timeSlot3, timeSlot4;

  const RoomcardAprrover({
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
  State<RoomcardAprrover> createState() => _RoomcardApproverState();
}

class _RoomcardApproverState extends State<RoomcardAprrover> {
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
              backgroundColor: WidgetStateProperty.all(buttonColor),
              padding: WidgetStateProperty.all(
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
        child: Column(
          children: [
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