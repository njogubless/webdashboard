import 'package:flutter/material.dart';
import 'package:hikers_dash/services/database.dart';
import 'package:hikers_dash/services/models/client.dart';

class ApprovedUsersPage extends StatelessWidget {
  const ApprovedUsersPage({
    required this.isClient,
    Key? key,
  }) : super(key: key);

  final bool isClient;

  // Function to build the table rows
  Widget buildTable(List<Client> users) {
    return DataTable(
      columns: [
        DataColumn(label: Text('Name')),
        DataColumn(label: Text('Email')),
        DataColumn(label: Text('Role')),
      ],
      rows: users.map((user) {
        return DataRow(cells: [
          DataCell(Text(user.clientName)), // Display Name
          DataCell(Text(user.clientEmail)), // Display Email
          DataCell(Text(user.role)), // Display Role
        ]);
      }).toList(),
    );
  }

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
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: buildTable(approvedUsers),
                  ),
                );
        },
      ),
    );
  }
}

class PendingUsersPage extends StatelessWidget {
  const PendingUsersPage({
    required this.isClient,
    Key? key,
  }) : super(key: key);

  final bool isClient;

//function to approve a client
  void approveClient(Client client) {
    Database.verifyUser(client).then((_) {
      // Handle UI updates or refresh here
      // You can use setState or another state management solution
    }).catchError((error) {
      // Handle errors
      print('Error approving client: $error');
    });
  }

//function to reject a client

  void rejectclient(Client client) {
    //call a function from the database to change the satus
    //from 'pending' to 'rejected'
    Database.rejectClient(client).then((_) {
      //handle UI updates or refresh here
    }).catchError((error) {
      print('Error rejecting client: $error');
    });
  }

  // Function to build the table rows
Widget buildTable(List<Client> users) {
  return DataTable(
    columns: [
      DataColumn(label: Text('Name')),
      DataColumn(label: Text('Email')),
      DataColumn(label: Text('Role')),
      DataColumn(label: Text('Action')),
    ],
    rows: users.map((user) {
      return DataRow(cells: [
        DataCell(Text(user.clientName)), // Display Name
        DataCell(Text(user.clientEmail)), // Display Email
        DataCell(Text(user.role)), // Display Role
        DataCell(Row(
          children: [
            IconButton(
              icon: Icon(Icons.check), // Action to verify user
              onPressed: () {
                approveClient(user); // Call your approval function
              },
            ),
            IconButton(
              icon: Icon(Icons.close), // Action to reject user
              onPressed: () {
                rejectclient(user); // Call your rejection function
              },
            ),
          ],
        )),
      ]);
    }).toList(),
  );
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
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: buildTable(pendingUsers),
                  ),
                );
        },
      ),
    );
  }
}

class RejectedUsersPage extends StatelessWidget {
  const RejectedUsersPage({
    required this.isClient,
    Key? key,
  }) : super(key: key);

  final bool isClient;

  void approveRejectedClient(Client client) {
    Database.approveRejectedClient(client).then((_) {
      // Handle UI updates or refresh here
      // You can use setState or another state management solution
    }).catchError((error) {
      // Handle errors
      print('Error approving rejected client: $error');
    });
  }

  // Function to build the table rows
  Widget buildTable(List<Client> users) {
    return DataTable(
      columns: [
        DataColumn(label: Text('Name')),
        DataColumn(label: Text('Email')),
        DataColumn(label: Text('Role')),
        DataColumn(label: Text('Action')),
      ],
      rows: users.map((user) {
        return DataRow(cells: [
          DataCell(Text(user.clientName)), // Display Name
          DataCell(Text(user.clientEmail)), // Display Email
          DataCell(Text(user.role)), // Display Role
          DataCell(IconButton(
            icon: Icon(Icons.check), // Action to verify user
            onPressed: () {
              approveRejectedClient(user); // Call your approval function
            },
          )),
        ]);
      }).toList(),
    );
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
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: buildTable(rejectedUsers),
                  ),
                );
        },
      ),
    );
  }
}
