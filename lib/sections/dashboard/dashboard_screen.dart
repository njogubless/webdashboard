import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: SideBarMenu(),
          ),
          Expanded(
            flex: 5,
            child: MainContent(),
          ),
        ],
      ),
    );
  }
}

class SideBarMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: Column(
        children: [
          ListTile(
            title: Text('Dashboard'),
            onTap: () {
              // Handle dashboard menu item tap
            },
          ),
          ListTile(
            title: Text('Users'),
            onTap: () {
              // Handle users menu item tap
            },
          ),
          ListTile(
            title: Text('Settings'),
            onTap: () {
              // Handle settings menu item tap
            },
          ),
        ],
      ),
    );
  }
}

class MainContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (BuildContext context, SizingInformation sizingInformation) {
        if (sizingInformation.isDesktop) {
          return Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to the Dashboard!',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16.0),
                Text(
                  'This is the main content area.',
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
            ),
          );
        } else {
          return Container(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                'Dashboard',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),
          );
        }
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: DashboardScreen(),
  ));
}
