// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RatingsPage extends StatelessWidget {
  const RatingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ratings'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('feedback').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No feedback available.'));
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var feedback =
                  snapshot.data!.docs[index].data() as Map<String, dynamic>;
              var timestamp = feedback['timestamp']?.toDate();
              var message = feedback['message'];
              // You can access 'name' and 'role' if you have these fields in your Firestore documents
              var name = feedback['name'] ?? '';
              var role = feedback['role'] ?? '';

              return Column(
                children: [
                  ListTile(
                    title: Text('Name: ${name ?? 'N/A'}'),
                    subtitle: Text('Role:${role ?? 'N/A'}'),
                  ),
                  ListTile(
                    title: Text('Time: ${timestamp ?? 'N/A'}'),
                    subtitle: Text('Feedback: ${message ?? 'N/A'}'),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
