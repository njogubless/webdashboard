import 'package:flutter/material.dart';
import 'package:hikers_dash/services/database.dart';
import 'package:hikers_dash/services/models/client.dart';

class ApprovedUsersPage extends StatelessWidget {
  const ApprovedUsersPage({
    required this.isClient,
    super.key,
  });
  final bool isClient;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Approved Users',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 30,
            color: Colors.indigo,
          ),
        ),
      ),
      body: FutureBuilder<List<Client>>(
        future: Database.getApprovedClients(),
        initialData: [],
        builder: (context, snapshot) {
          final approvedUsers = snapshot.data!
              .where((element) => isClient
                  ? element.role == 'client'
                  : element.role != 'client')
              .toList();
          return ListView.builder(
            itemCount: approvedUsers.length,
            itemBuilder: (context, index) {
              final user = approvedUsers[index];
              return ListTile(
                title: Text(user.clientName),
                subtitle: Text(user.clientEmail),
                // Add any additional user details you want to display
              );
            },
          );
        },
      ),
    );
  }
}

class PendingUsersPage extends StatelessWidget {
  const PendingUsersPage({
    required this.isClient,
    super.key,
  });

  final bool isClient;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Pending Users',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 30,
            color: Colors.indigo,
          ),
        ),
      ),
      body: FutureBuilder<List<Client>>(
        future: Database.getPendingClients(),
        initialData: [],
        builder: (context, snapshot) {
          final pendingUsers = snapshot.data!
              .where((element) => isClient
                  ? element.role == 'client'
                  : element.role != 'client')
              .toList();
          return ListView.builder(
            itemCount: pendingUsers.length,
            itemBuilder: (context, index) {
              final user = pendingUsers[index];
              return ListTile(
                title: Text(user.clientName),
                subtitle: Text(user.clientEmail),
                // Add any additional user details you want to display
              );
            },
          );
        },
      ),
    );
  }
}

class RejectedUsersPage extends StatelessWidget {
  const RejectedUsersPage({
    required this.isClient,
    super.key,
  });

  final bool isClient;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Rejected Users',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 30,
            color: Colors.indigo,
          ),
        ),
      ),
      body: FutureBuilder<List<Client>>(
        future: Database.getRejectedClients(),
        initialData: [],
        builder: (context, snapshot) {
          final rejectedUsers = snapshot.data!
              .where((element) => isClient
                  ? element.role == 'client'
                  : element.role != 'client')
              .toList();
          return ListView.builder(
            itemCount: rejectedUsers.length,
            itemBuilder: (context, index) {
              final user = rejectedUsers[index];
              return ListTile(
                title: Text(user.clientName),
                subtitle: Text(user.clientEmail),
                // Add any additional user details you want to display
              );
            },
          );
        },
      ),
    );
  }
}
