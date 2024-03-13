import 'package:flutter/material.dart';
import 'package:hikers_dash/sections/Logistics/logistics.dart';
import 'package:hikers_dash/sections/booked_events/booked_events.dart';
import 'package:hikers_dash/sections/add_events/add_events.dart';
import 'package:hikers_dash/sections/manage_events/manage_events.dart';
import 'package:hikers_dash/sections/ratings/ratings.dart';
import 'package:hikers_dash/sections/settings/settings.dart';
import 'package:hikers_dash/sections/verify_users/verify_users.dart';
import 'package:hikers_dash/sections/welcome/welcome.dart';
import 'package:hikers_dash/services/auth.dart';

class HomeNavigation extends StatefulWidget {
  const HomeNavigation({super.key});

  @override
  State<HomeNavigation> createState() => _HomeNavigationState();
}

class _HomeNavigationState extends State<HomeNavigation> {
  int _selectedIndex = 0;
  bool _isClient = false;

  void switchToSection(int index, bool isClient) {
    setState(() {
      _selectedIndex = index;
      _isClient = isClient;
    });
  }

  Widget _showSection(int index) {
    switch (index) {
      case 0:
        return WelcomeSection(switchPage: switchToSection);
      case 1:
        return ApprovedUsersPage(
          isClient: _isClient,
        );
      case 2:
        return PendingUsersPage(
          isClient: _isClient,
        );
      case 3:
        return RejectedUsersPage(
          isClient: _isClient,
        );
      case 4:
        return ApprovedUsersPage(
          isClient: _isClient,
        );
      case 5:
        return const AddEvents();
      case 6:
        return const ManageEvents();
      case 7:
        return const BookedEvents();
      case 8:
        return const RatingsPage();
      case 9:
        return const SettingsPage();
      case 10:
        return LogisticsPage(
        logisticsData: [],
        );
      default:
        AuthService().signOut();
        return const Center();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //HOME
                  ListTile(
                    leading: Icon(Icons.home),
                    title: const Text('Home'),
                    onTap: () => switchToSection(0, false),
                  ),
                  ExpansionTile(
                    leading: Icon(Icons.person_2_outlined),
                    title: const Text('Clients'),
                    children: [
                      ListTile(
                        title: const Text('Approved'),
                        onTap: () => switchToSection(1, true),
                      ),
                      ListTile(
                        title: const Text('Pending'),
                        onTap: () => switchToSection(2, true),
                      ),
                      ListTile(
                        title: const Text('Rejected'),
                        onTap: () => switchToSection(3, true),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    leading: Icon(Icons.person_outline),
                    title: const Text('Employees'),
                    children: [
                      ListTile(
                        title: const Text('Approved'),
                        onTap: () => switchToSection(1, false),
                      ),
                      ListTile(
                        title: const Text('Pending'),
                        onTap: () => switchToSection(2, false),
                      ),
                      ListTile(
                        title: const Text('Rejected'),
                        onTap: () => switchToSection(3, false),
                      ),
                    ],
                  ),
                  ListTile(
                    leading: Icon(Icons.person_2_rounded),
                    title: const Text('Event Manager'),
                    onTap: () => switchToSection(6, false),
                  ),
                  ListTile(
                    leading: Icon(Icons.person_2_sharp),
                    title: const Text('Finance Manager'),
                    onTap: () => switchToSection(7, false),
                  ),ListTile(
                        leading: Icon(Icons.local_shipping),
                        title: const Text('Logistics'),
                        onTap: () => switchToSection(10, false),
                      ), ListTile(
                    leading: Icon(Icons.reviews_outlined),
                    title: const Text('Ratings'),
                    onTap: () => switchToSection(8,false),
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: const Text('Settings'),
                    onTap: () => switchToSection(9,false),
                  ),
                  ListTile(
                    title: const Text(
                      'Logout',
                      style: TextStyle(color: Colors.red),
                    ),
                    leading: const Icon(
                      Icons.logout_rounded,
                      color: Colors.red,
                    ),
                    onTap: () {
                      AuthService().signOut();
                    },
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 5,
            child: _showSection(_selectedIndex),
          ),
        ],
      ),
    );
  }
}
