import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:hikers_dash/services/models/booking.dart';
import 'package:hikers_dash/services/models/client.dart';
import 'package:hikers_dash/services/models/event.dart';
import 'package:hikers_dash/services/models/logistics.dart';
import 'package:hikers_dash/services/models/payment.dart';

class Database {
  // Initialize Firestore
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  static var instance;


  static Future<List<Payment>> getrecordPayments() async {
    try {
      QuerySnapshot querySnapshot = await firestore.collection('payments').get();

      List<Payment> payments = [];

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        String clientName = doc['clientName'];
        double amountPaid = doc['amountPaid'];
        double totalCost = doc['totalCost'];
        String email = doc['email'];
        String event = doc['event'];
        String mpesaCode = doc['mpesaCode'];
        // ignore: unused_local_variable
        String Status= doc['status'];

        Payment payment = Payment(
          clientName: clientName,
          amountPaid: amountPaid,
          email: email,
          event: event,
          mpesaCode: mpesaCode,
          totalCost: totalCost,
          Status: doc['status'] ?? '',
          id: doc['id'], 
        );

        payments.add(payment);
      }

      return payments;
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching payments: $e');
      return [];
    }
  }

  void fetchLogisticsData() async {
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('allocations').get();
    List<LogisticsData> tempData = [];

    querySnapshot.docs.forEach((doc) {
      //print("Document ID: ${doc.id}");
      print("Event: ${doc['event']}");
      print("Driver: ${doc['driver']}");
      print("Guide: ${doc['guide']}");

      tempData.add(LogisticsData(
        eventName: doc['event'] ?? '',
        driver: doc['driver'] ?? '',
        guide: doc['guide'] ?? '',
      ));
    });

  } catch (e) {
    print("Error fetching logistics data: $e");
  }
}


  static Future<List<Payment>> getPaymentsByStatus(String status) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('payments')
          .where('status', isEqualTo: status)
          .get();

      List<Payment> payments = querySnapshot.docs.map((doc) {
        return Payment(
          id: doc['id'], 
          clientName: doc['clientName'],
          amountPaid: doc['amountPaid'],
          email: doc['email'],
          event: doc['event'],
          mpesaCode: doc['mpesaCode'],
          totalCost: doc['totalCost'],
          Status: doc['status'],
        );
      }).toList();

      return payments;
    } catch (e) {
      throw Exception('Error getting payments by status: $e');
    }
  }

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
      final user = users
          .firstWhereOrNull((user) => user.clientEmail == booking.userEmail);
      final event =
          events.firstWhereOrNull((event) => event.eventID == booking.eventID);
      // Fix breaking error
      if (event == null) {
        continue;
      }
      if (user == null) {
        continue;
      }
      bookedEvents.add(BookedEventItem(
        userEmail: user.clientEmail,
        userName: user.clientName,
        eventName: event.eventName,
        bookingDate: booking.bookingDate,
        eventCost: event.eventCost,
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

  // Retrieve approved clients
  static Future<List<Client>> getApprovedClients() async {
    final QuerySnapshot querySnapshot = await firestore
        .collection('clients')
        .where('status', isEqualTo: 'Verified')
        .get();
    final List<QueryDocumentSnapshot> docs = querySnapshot.docs;
    return docs
        .map((doc) => Client.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  // Retrieve approved clients
  static Future<List<Client>> getRejectedClients() async {
    final QuerySnapshot querySnapshot = await firestore
        .collection('clients')
        .where('status', isEqualTo: 'Rejected')
        .get();
    final List<QueryDocumentSnapshot> docs = querySnapshot.docs;
    return docs
        .map((doc) => Client.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  // Retrieve pending clients
  static Future<void> verifyUser(Client client) async {
    final QuerySnapshot querySnapshot = await firestore
        .collection('clients')
        .where('clientEmail', isEqualTo: client.clientEmail)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final clientDocument = querySnapshot.docs.first;
      await clientDocument.reference.update({'status': 'Verified'});
    } else {
      throw Exception('Client not found');
    }
    //await querySnapshot.docs.first.reference.update({'status': 'Verified'});
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

  //aproving rejected users
static Future<void> approveRejectedClient(Client client) async {
  final QuerySnapshot querySnapshot = await firestore
      .collection('clients')
      .where('clientEmail', isEqualTo: client.clientEmail)
      .get();

  if (querySnapshot.docs.isNotEmpty) {
    final clientDocument = querySnapshot.docs.first;
    await clientDocument.reference.update({'status': 'Verified'});
  } else {
    throw Exception('Client not found');
  }
}

//reject user verification
// Add this method to your Database class
static Future<void> rejectClient(Client client) async {
  final QuerySnapshot querySnapshot = await firestore
      .collection('clients')
      .where('clientEmail', isEqualTo: client.clientEmail)
      .get();

  if (querySnapshot.docs.isNotEmpty) {
    final clientDocument = querySnapshot.docs.first;
    await clientDocument.reference.update({'status': 'Rejected'});
  } else {
    throw Exception('Client not found');
  }
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
