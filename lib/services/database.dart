import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hikers_dash/services/models/booking.dart';
import 'package:hikers_dash/services/models/client.dart';
import 'package:hikers_dash/services/models/event.dart';

class Database {
  // Initialize Firestore
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Save registered client data
  static Future<void> saveClientData(Client client) async {
    final DocumentReference docRef = firestore.collection('clients').doc();
    await docRef.set(client.toJson());
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
  static Future<List<Booking>> getBookedEvents() async {
    final QuerySnapshot querySnapshot =
        await firestore.collection('bookings').get();
    final List<QueryDocumentSnapshot> docs = querySnapshot.docs;
    return docs
        .map((doc) => Booking.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  // Retrieve a booked events
  static Future<List<Client>> getPendingClients() async {
    final QuerySnapshot querySnapshot = await firestore
        .collection('clients')
        .where('verified', isEqualTo: false)
        .get();
    final List<QueryDocumentSnapshot> docs = querySnapshot.docs;
    return docs
        .map((doc) => Client.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }
}
