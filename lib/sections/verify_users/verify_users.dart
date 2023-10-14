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
          return approvedUsers.isEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 70),
                    Padding(
                      padding: const EdgeInsets.only(left: 18),
                      child: Text(
                        'No approved users',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                )
              : ListView.builder(
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

  // Function to approve a client
  void approveClient(Client client) {
    // Call the approveClient function from the database class
    Database.verifyUser(client).then((_) {
      // Handle UI updates or refresh here
      // setState can be used here
    }).catchError((error) {
      // Handle errors
      print('Error approving client: $error');
    });
  }

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
          return pendingUsers.isEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 70),
                    Padding(
                      padding: const EdgeInsets.only(left: 18),
                      child: Text(
                        'No pending users',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                )
              : ListView.builder(
                  itemCount: pendingUsers.length,
                  itemBuilder: (context, index) {
                    final user = pendingUsers[index];
                    return ListTile(
                      title: Text(user.clientName),
                      subtitle: Text(user.clientEmail),
                      // Add any additional user details you want to display
                      trailing: IconButton(
                        icon: const Icon(Icons.check),
                        onPressed: () {
                          approveClient(user);
                        },
                      ),
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

  // Function to approve a rejected client
  void approveRejectedClient(Client client) {
    // Call a function from your Database class to change the status
    // from 'Rejected' to 'Verified' or another appropriate status.
    Database.revokeUser(client)
      .then((_) {
        // Handle UI updates or refresh here
        // You can use setState or another state management solution
      })
      .catchError((error) {
        // Handle errors
        print('Error approving rejected client: $error');
      });
  }
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
          return rejectedUsers.isEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 70),
                    Padding(
                      padding: const EdgeInsets.only(left: 18),
                      child: Text(
                        'No rejected users',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                )
              : ListView.builder(
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
