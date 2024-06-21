import 'package:flutter/material.dart';
import 'package:hikers_dash/services/database.dart';
import 'package:hikers_dash/services/models/client.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final bool isClient;

  const SearchBar({
    Key? key,
    required this.controller,
    required this.onChanged,
    required this.isClient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.grey[200],
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: isClient ? 'Search clients...' : 'Search employees...',
          prefixIcon: Icon(Icons.search),
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 10.0, vertical: 14.0),
        ),
      ),
    );
  }
}

class ApprovedUsersPage extends StatefulWidget {
  const ApprovedUsersPage({
    required this.isClient,
    Key? key,
  }) : super(key: key);

  final bool isClient;

  @override
  _ApprovedUsersPageState createState() => _ApprovedUsersPageState();
}

class _ApprovedUsersPageState extends State<ApprovedUsersPage> {
  late List<Client> _clients;
  late List<Client> _filteredClients;
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _clients = [];
    _filteredClients = [];
    _searchController = TextEditingController();
    _loadData();
  }

  void _loadData() async {
    List<Client> clients = await Database.getClients();
    setState(() {
      _clients = clients
          .where((client) => widget.isClient
              ? client.role == 'client'
              : client.role != 'client')
          .toList();
      _filteredClients = _clients;
    });
  }

  void _performSearch(String query) {
    setState(() {
      _filteredClients = _clients
          .where((client) =>
              client.clientName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Function to build the table rows
  Widget buildTable(List<Client> users) {
    return DataTable(
      headingRowColor:
          MaterialStateColor.resolveWith((states) => Colors.blueAccent),
      columns: [
        DataColumn(label: Text('UID')),
        DataColumn(label: Text('Name')),
        DataColumn(label: Text('Email')),
        DataColumn(label: Text('Role')),
      ],
      rows: users.map((user) {
        return DataRow(cells: [
          DataCell(Text('${user.uid}')), // Display UID
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(Icons.search),
                SizedBox(width: 10),
                SearchBar(
                  controller: _searchController,
                  onChanged: (value) {
                    _performSearch(value);
                  },
                  isClient: widget.isClient,
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: buildTable(_filteredClients),
              ),
            ),
          ),
        ],
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

  // function to approve a client
  void approveClient(Client client) {
    Database.verifyUser(client).then((_) {
      // Handle UI updates or refresh here
      // You can use setState or another state management solution
    }).catchError((error) {
      // Handle errors
      print('Error approving client: $error');
    });
  }

  // function to reject a client
  void rejectClient(Client client) {
    // call a function from the database to change the status
    // from 'pending' to 'rejected'
    Database.rejectClient(client).then((_) {
      // handle UI updates or refresh here
    }).catchError((error) {
      print('Error rejecting client: $error');
    });
  }

  // Function to build the table rows
  Widget buildTable(List<Client> users) {
    return DataTable(
      headingRowColor:
          MaterialStateColor.resolveWith((states) => Colors.blueAccent),
      columns: [
         DataColumn(label: Text('UID')),
        DataColumn(label: Text('Name')),
        DataColumn(label: Text('Email')),
        DataColumn(label: Text('Role')),
        DataColumn(label: Text('Action')),
      ],
      rows: users.map((user) {
        return DataRow(cells: [
          DataCell(Text('${user.uid}')), // Display UID
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
                  rejectClient(user); // Call your rejection function
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
      headingRowColor:
          MaterialStateColor.resolveWith((states) => Colors.blueAccent),
      columns: [
        DataColumn(label: Text('UID')),
        DataColumn(label: Text('Name')),
        DataColumn(label: Text('Email')),
        DataColumn(label: Text('Role')),
        DataColumn(label: Text('Action')),
      ],
      rows: users.map((user) {
        return DataRow(cells: [
           DataCell(Text('${user.uid}')), // Display UID
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
