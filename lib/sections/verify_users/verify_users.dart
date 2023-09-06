import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/database.dart';

enum UserStatus { Verified, pending, Rejected }

class FirebaseUser {
  final String name;
  final String email;
  final String role;
  final UserStatus status;

  FirebaseUser(this.name, this.email, this.role, this.status);
}

class AuthNotifier with ChangeNotifier {
  final _database = Database.instance.reference();

  List<FirebaseUser> approvedUsers = [];
  List<FirebaseUser> pendingUsers = [];
  List<FirebaseUser> rejectedUsers = [];

  Future<void> fetchUsers() async {
    final dataSnapshot = await _database.child('users').once();
    print(dataSnapshot);

    if (dataSnapshot.value != null) {
      final usersMap = dataSnapshot.value as Map<dynamic, dynamic>;

      approvedUsers.clear();
      pendingUsers.clear();
      rejectedUsers.clear();

      usersMap.forEach((key, userData) {
        final name = userData['name'];
        final email = userData['email'];
        final role = userData['role'];
        final status = userData['status'];

        final firebaseUser = FirebaseUser(
          name,
          email,
          role,
          _getUserStatus(status),
        );

        switch (firebaseUser.status) {
          case UserStatus.Verified:
            approvedUsers.add(firebaseUser);
            break;
          case UserStatus.pending:
            pendingUsers.add(firebaseUser);
            break;
          case UserStatus.Rejected:
            rejectedUsers.add(firebaseUser);
            break;
        }
      });

      notifyListeners();
    }
  }

  UserStatus _getUserStatus(String status) {
    switch (status) {
      case 'approved':
        return UserStatus.Verified;
      case 'pending':
        return UserStatus.pending;
      case 'rejected':
        return UserStatus.Rejected;
      default:
        return UserStatus.Verified;
    }
  }
}

class ApprovedUsersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authNotifier = Provider.of<AuthNotifier>(context);
    final approvedUsers = authNotifier.approvedUsers;
    print('Approved Users $approvedUsers');
    return Scaffold(
      appBar: AppBar(
        title: Text('Approved Users'),
      ),
      //body: ListView.builder(
      // itemCount: approvedUsers.length,
      //itemBuilder: (context, index) {
      //final user = approvedUsers[index];

      // return ListTile(
      //title: Text(user.name),
      //subtitle: Text(user.email),
      // Add any additional user details you want to display
      //);
      // },
      //),
      body: Text('Approved Users'),
    );
  }
}

class PendingUsersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authNotifier = Provider.of<AuthNotifier>(context);
    final pendingUsers = authNotifier.pendingUsers;

    return Scaffold(
      appBar: AppBar(
        title: Text('Pending Users'),
      ),
      body: ListView.builder(
        itemCount: pendingUsers.length,
        itemBuilder: (context, index) {
          final user = pendingUsers[index];

          return ListTile(
            title: Text(user.name),
            subtitle: Text(user.email),
            // Add any additional user details you want to display
          );
        },
      ),
    );
  }
}

class RejectedUsersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authNotifier = Provider.of<AuthNotifier>(context);
    final rejectedUsers = authNotifier.rejectedUsers;

    return Scaffold(
      appBar: AppBar(
        title: Text('Rejected Users'),
      ),
      body: ListView.builder(
        itemCount: rejectedUsers.length,
        itemBuilder: (context, index) {
          final user = rejectedUsers[index];

          return ListTile(
            title: Text(user.name),
            subtitle: Text(user.email),
            // Add any additional user details you want to display
          );
        },
      ),
    );
  }
}

class AdminHomePage extends StatefulWidget {
  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  String _selectedMenuItem = 'Approved Users';

  @override
  void initState() {
    super.initState();
    Provider.of<AuthNotifier>(context, listen: false).fetchUsers();
  }

  void _onMenuItemSelected(String value) {
    setState(() {
      _selectedMenuItem = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body: Row(
        children: [
          NavigationRail(
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.check_circle),
                label: Text('Approved Users'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.pending),
                label: Text('Pending Users'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.cancel),
                label: Text('Rejected Users'),
              ),
            ],
            selectedIndex: _getSelectedIndex(),
            onDestinationSelected: (int index) {
              _onMenuItemSelected(_getMenuItemFromIndex(index));
            },
          ),
          VerticalDivider(),
          Expanded(
            child: _selectedPage,
          ),
        ],
      ),
    );
  }

  int _getSelectedIndex() {
    switch (_selectedMenuItem) {
      case 'Approved Users':
        return 0;
      case 'Pending Users':
        return 1;
      case 'Rejected Users':
        return 2;
      default:
        return 0;
    }
  }

  String _getMenuItemFromIndex(int index) {
    switch (index) {
      case 0:
        return 'Approved Users';
      case 1:
        return 'Pending Users';
      case 2:
        return 'Rejected Users';
      default:
        return 'Approved Users';
    }
  }

  Widget get _selectedPage {
    switch (_selectedMenuItem) {
      case 'Approved Users':
        return ApprovedUsersPage();
      case 'Pending Users':
        return PendingUsersPage();
      case 'Rejected Users':
        return RejectedUsersPage();
      default:
        return Container();
    }
  }
}
