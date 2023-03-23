import 'package:flutter/material.dart';
import 'package:hikers_dash/sections/booked_events/booked_events.dart';
import 'package:hikers_dash/sections/add_events/add_events.dart';
import 'package:hikers_dash/sections/manage_events/manage_events.dart';
import 'package:hikers_dash/sections/verify_users/verify_users.dart';
import 'package:hikers_dash/sections/welcome/welcome.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  void switchToSection(int index) => setState(() {
        _selectedIndex = index;
      });

  Widget _showSection(int index) {
    switch (index) {
      case 0:
        return WelcomeSection(switchPage: switchToSection);
      case 1:
        return const VerifyUsers();
      case 2:
        return const AddEvents();
      case 3:
        return const ManageEvents();
      case 4:
        return const BookedEvents();
      default:
        return const Center(
          child: Text('Home'),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            onDestinationSelected: (index) => setState(() {
              _selectedIndex = index;
            }),
            minWidth: 100,
            elevation: 1,
            useIndicator: true,
            indicatorColor: Colors.cyanAccent,
            labelType: NavigationRailLabelType.all,
            destinations: const <NavigationRailDestination>[
              NavigationRailDestination(
                icon: Icon(Icons.house_outlined),
                selectedIcon: Icon(Icons.house),
                label: Text('Home'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.verified_user_outlined),
                selectedIcon: Icon(Icons.verified_user),
                label: Text('Verify user'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.event_note_outlined),
                selectedIcon: Icon(Icons.event_note),
                label: Text('Add Events'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.event_note_outlined),
                selectedIcon: Icon(Icons.event_note),
                label: Text('Manage Events'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.event_available_outlined),
                selectedIcon: Icon(Icons.event_available),
                label: Text('Booked Events'),
              ),
            ],
            selectedIndex: _selectedIndex,
          ),
          _showSection(_selectedIndex),
        ],
      ),
    );
  }
}
