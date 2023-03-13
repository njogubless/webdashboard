class Booking {
  final String userEmail;
  final String eventName;
  final String bookingDate;
  const Booking({
    required this.userEmail,
    required this.eventName,
    required this.bookingDate,
  });

  factory Booking.fromJson(Map<String, dynamic> booking) {
    return Booking(
      userEmail: booking['userEmail'],
      eventName: booking['eventName'],
      bookingDate: booking['bookingDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'userEmail': userEmail,
      'eventName': eventName,
      'bookingDate': bookingDate,
    };
  }
}
