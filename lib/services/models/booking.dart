class Booking {
  final String userEmail;
  final String eventID;
  final String bookingDate;
  const Booking({
    required this.userEmail,
    required this.eventID,
    required this.bookingDate,
  });

  factory Booking.fromJson(Map<String, dynamic> booking) {
    return Booking(
      userEmail: booking['userEmail'] ?? '',
      eventID: booking['eventID'] ?? '',
      bookingDate: booking['bookingDate'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'userEmail': userEmail,
      'eventID': eventID,
      'bookingDate': bookingDate,
    };
  }
}

class BookedEventItem {
  final String userEmail;
  final String userName;
  final String eventName;
  final String bookingDate;
  const BookedEventItem({
    required this.userEmail,
    required this.userName,
    required this.eventName,
    required this.bookingDate,
  });
}
