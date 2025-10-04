class Room {
  String image;
  String name;
  String size;
  List<TimeSlot> timeSlots;

  Room(this.image, this.name, this.size, this.timeSlots);
}

class TimeSlot {
  String time;
  String status;

  TimeSlot(this.time, this.status);
}
