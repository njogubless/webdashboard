import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hikers_dash/services/models/event.dart';

class RatingPage extends StatelessWidget {
  const RatingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Ratings'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('rates').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final rates = snapshot.data!.docs;

          return ListView.builder(
            itemCount: rates.length,
            itemBuilder: (context, index) {
              final rateData = rates[index].data() as Map<String, dynamic>;
              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('events')
                    .doc(rateData['eventId'])
                    .get(),
                builder: (context, eventSnapshot) {
                  if (!eventSnapshot.hasData) {
                    return const SizedBox.shrink();
                  }

                  final eventData = eventSnapshot.data!.data() as Map<String, dynamic>;
                  final event = Event.fromJson(eventData);

                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event.eventName,
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Text('Client Name: ${rateData['clientName']}'),
                          const SizedBox(height: 10),
                          Text('Rating: ${rateData['rating']}'),
                          const SizedBox(height: 10),
                          Text('Comment: ${rateData['comment']}'),
                          const SizedBox(height: 10),
                          Text('Timestamp: ${rateData['timestamp'].toDate()}'),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
