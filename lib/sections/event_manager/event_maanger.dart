import 'package:flutter/material.dart';

class Event {
  final String eventName;
  final String customerName;
  final int numberOfTickets;

  Event({
    required this.eventName,
    required this.customerName,
    required this.numberOfTickets,
  });
}

class EventManagerPage extends StatelessWidget {
  final List<Event> events = [
    Event(
      eventName: 'Hiking Adventure',
      customerName: 'John Doe',
      numberOfTickets: 2,
    ),
    Event(
      eventName: 'Camping Trip',
      customerName: 'Jane Smith',
      numberOfTickets: 1,
    ),
    Event(
      eventName: 'Nature Walk',
      customerName: 'Mike Johnson',
      numberOfTickets: 3,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Manager'),
      ),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return ListTile(
            title: Text(event.eventName),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Customer: ${event.customerName}'),
                Text('Number of Tickets: ${event.numberOfTickets}'),
              ],
            ),
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
  String _selectedMenuItem = 'Event Manager';
  Widget _selectedPage = EventManagerPage();

  void _onMenuItemSelected(String value) {
    setState(() {
      _selectedMenuItem = value;
      if (_selectedMenuItem == 'Event Manager') {
        _selectedPage = EventManagerPage();
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
                label: Text('Event Manager'),
              ),
            ],
            selectedIndex: 0,
            onDestinationSelected: (int index) {
              _onMenuItemSelected('Event Manager');
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
}

void main() {
  runApp(MaterialApp(
    title: 'Admin Interface',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: AdminHomePage(),
  ));
}
