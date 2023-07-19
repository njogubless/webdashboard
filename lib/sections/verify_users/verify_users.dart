import 'package:flutter/material.dart';

enum UserStatus { approved, pending, rejected }

class User {
  final String name;
  final UserStatus status;

  User(this.name, this.status);
}

class UsersPage extends StatelessWidget {
  final List<User> users = [
    User('John Doe', UserStatus.approved),
    User('Jane Smith', UserStatus.pending),
    User('Mike Johnson', UserStatus.rejected),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(users[index].name),
            subtitle: Text(users[index].status.toString()),
          );
        },
      ),
    );
  }
}

class ApprovedUsersPage extends StatelessWidget {
  final List<User> users = [
    User('John Doe', UserStatus.approved),
    User('Jane Smith', UserStatus.approved),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Approved Users'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(users[index].name),
            subtitle: Text(users[index].status.toString()),
          );
        },
      ),
    );
  }
}

class PendingUsersPage extends StatelessWidget {
  final List<User> users = [
    User('Mike Johnson', UserStatus.pending),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pending Users'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(users[index].name),
            subtitle: Text(users[index].status.toString()),
          );
        },
      ),
    );
  }
}

class RejectedUsersPage extends StatelessWidget {
  final List<User> users = [
    User('Alex Brown', UserStatus.rejected),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rejected Users'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(users[index].name),
            subtitle: Text(users[index].status.toString()),
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
  String _selectedMenuItem = 'Users';
  Widget _selectedPage = UsersPage();

  void _onMenuItemSelected(String value) {
    setState(() {
      _selectedMenuItem = value;
      if (_selectedMenuItem == 'Users') {
        _selectedPage = UsersPage();
      } else if (_selectedMenuItem == 'Approved Users') {
        _selectedPage = ApprovedUsersPage();
      } else if (_selectedMenuItem == 'Pending Users') {
        _selectedPage = PendingUsersPage();
      } else if (_selectedMenuItem == 'Rejected Users') {
        _selectedPage = RejectedUsersPage();
      }
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
                icon: Icon(Icons.people),
                label: Text('Users'),
              ),
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
    if (_selectedMenuItem == 'Users') {
      return 0;
    } else if (_selectedMenuItem == 'Approved Users') {
      return 1;
    } else if (_selectedMenuItem == 'Pending Users') {
      return 2;
    } else if (_selectedMenuItem == 'Rejected Users') {
      return 3;
    }
    return 0; // Default to Users if none matches
  }

  String _getMenuItemFromIndex(int index) {
    switch (index) {
      case 0:
        return 'Users';
      case 1:
        return 'Approved Users';
      case 2:
        return 'Pending Users';
      case 3:
        return 'Rejected Users';
      default:
        return 'Users';
    }
  }
}
