import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hikers_dash/services/models/event.dart';

class RatingPage extends StatefulWidget {
  const RatingPage({Key? key}) : super(key: key);

  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _updateSearchQuery(String newQuery) {
    setState(() {
      _searchQuery = newQuery;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Ratings'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search here...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                prefixIcon: const Icon(Icons.search),
              ),
              onChanged: _updateSearchQuery,
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('rates').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final rates = snapshot.data!.docs.where((doc) {
                  final rateData = doc.data() as Map<String, dynamic>;
                  final eventName = rateData['eventName']?.toString().toLowerCase() ?? '';
                  final clientName = rateData['clientName']?.toString().toLowerCase() ?? '';
                  final searchQuery = _searchQuery.toLowerCase();

                  return eventName.contains(searchQuery) || clientName.contains(searchQuery);
                }).toList();

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

                        final eventData = eventSnapshot.data?.data();
                        if (eventData == null) {
                          return const SizedBox.shrink();
                        }

                        try {
                          final eventMap = eventData as Map<String, dynamic>;
                          final event = Event.fromJson(eventMap);

                          return Card(
                            color: Colors.lightBlue[50],
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
                                  Text('Timestamp: ${rateData['timestamp'] != null ? rateData['timestamp'].toDate().toString() : 'No timestamp'}'),
                                ],
                              ),
                            ),
                          );
                        } catch (e) {
                          print('Error casting event data: $e');
                          return const SizedBox.shrink();
                        }
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
