import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hikers_dash/services/models/booking.dart';
import 'package:hikers_dash/services/models/client.dart';
import 'package:hikers_dash/services/models/event.dart';

class Database {
  // Initialize Firestore
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  static var instance;

  // Save registered client data
  static Future<void> saveClientData(Client client) async {
    final DocumentReference docRef = firestore.collection('clients').doc();
    await docRef.set(client.toJson());
  }

  // Save registered client data
  static Future<Client> getClientData(String email) async {
    final QuerySnapshot querySnapshot = await firestore
        .collection('clients')
        .where('clientEmail', isEqualTo: email)
        .get();
    final List<QueryDocumentSnapshot> docs = querySnapshot.docs;
    return docs
        .map((doc) => Client.fromJson(doc.data() as Map<String, dynamic>))
        .toList()
        .first;
  }

// Retrieve available events
  static Future<List<Event>> getAvailableEvents() async {
    final QuerySnapshot querySnapshot =
        await firestore.collection('events').get();
    final List<QueryDocumentSnapshot> docs = querySnapshot.docs;
    return docs
        .map((doc) => Event.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  // Save a booked event for a user
  static Future<void> saveBookedEvent(
      String userEmail, String eventName) async {
    final DocumentReference docRef = firestore.collection('bookings').doc();
    await docRef.set({
      'userEmail': userEmail,
      'eventName': eventName,
      'bookingDate': DateTime.now().toIso8601String(),
    });
  }

// Retrieve a booked events
  static Future<List<BookedEventItem>> getBookedEvents() async {
    final users = await getClients();
    final events = await getAvailableEvents();
    final QuerySnapshot querySnapshot =
        await firestore.collection('bookings').get();
    final List<QueryDocumentSnapshot> docs = querySnapshot.docs;
    final bookings = docs
        .map((doc) => Booking.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
    List<BookedEventItem> bookedEvents = [];
    for (final booking in bookings) {
      final user =
          users.where((user) => user.clientEmail == booking.userEmail).first;
      final event =
          events.where((event) => event.eventID == booking.eventID).first;
      bookedEvents.add(BookedEventItem(
        userEmail: user.clientEmail,
        userName: user.clientName,
        eventName: event.eventName,
        bookingDate: booking.bookingDate,
      ));
    }

    return bookedEvents;
  }

  // Create event
  static Future<void> createEvent(Event event) async {
    final DocumentReference docRef = firestore.collection('events').doc();
    await docRef.set(event.toJson());
  }

  // Retrieve pending clients
  static Future<List<Client>> getClients() async {
    final QuerySnapshot querySnapshot =
        await firestore.collection('clients').get();
    final List<QueryDocumentSnapshot> docs = querySnapshot.docs;
    return docs
        .map((doc) => Client.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  // Retrieve pending clients
  static Future<List<Client>> getPendingClients() async {
    final QuerySnapshot querySnapshot = await firestore
        .collection('clients')
        .where('status', isEqualTo: 'Pending')
        .get();
    final List<QueryDocumentSnapshot> docs = querySnapshot.docs;
    return docs
        .map((doc) => Client.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  // Retrieve pending clients
  static Future<void> verifyser(Client client) async {
    final QuerySnapshot querySnapshot = await firestore
        .collection('clients')
        .where('clientEmail', isEqualTo: client.clientEmail)
        .get();
    await querySnapshot.docs.first.reference.update({'status': 'Verified'});
  }

  // Retrieve pending clients
  static Future<void> revokeUser(Client client) async {
    final QuerySnapshot querySnapshot = await firestore
        .collection('clients')
        .where('status', isEqualTo: 'Verified')
        .where('clientEmail', isEqualTo: client.clientEmail)
        .get();
    await querySnapshot.docs.first.reference.update({'status': 'Rejected'});
  }

  // Retrieve pending clients
  static Future<void> deleteEvent(Event event) async {
    final QuerySnapshot querySnapshot = await firestore
        .collection('events')
        .where('eventName', isEqualTo: event.eventName)
        .get();
    await querySnapshot.docs.first.reference.delete();
  }

  static Future<int> getNumberOfEvents() async {
    final result = await firestore.collection('events').count().get();
    return result.count;
  }

  // Get number booked
  static Future<int> getNumberBooked(String eventID) async {
    final result = await firestore
        .collection('bookings')
        .where('eventID', isEqualTo: eventID)
        .count()
        .get();
    return result.count;
  }

  // Retrieve available events
  static Future<int> getTotalRevenue() async {
    int total = 0;
    final QuerySnapshot querySnapshot =
        await firestore.collection('events').get();
    final List<QueryDocumentSnapshot> docs = querySnapshot.docs;
    final events = docs
        .map((doc) => Event.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
    for (final event in events) {
      total += event.eventCost * await getNumberBooked(event.eventID);
    }
    return total;
  }
}
