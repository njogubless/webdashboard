import 'package:flutter/material.dart';
import 'package:hikers_dash/sections/Logistics/logistics.dart';
import 'package:hikers_dash/sections/Partners/partners.dart';
import 'package:hikers_dash/sections/Ratings/Ratings.dart';
import 'package:hikers_dash/sections/finance_details/finance_details.dart';
import 'package:hikers_dash/sections/add_events/add_events.dart';
import 'package:hikers_dash/sections/manage_events/manage_events.dart';
import 'package:hikers_dash/sections/Feedbacks/Feedback.dart';
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
        return const FeedbackPage();
      case 9:
        return const SettingsPage();
      case 10:
        return LogisticsPageScreen();
      case 11:
        return const PartnersPage();
      case 12:
        return const RatingPage();
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
            child: Container(
              color: const Color.fromARGB(255, 7, 89, 131), // Sidebar background color
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //HOME
                    _buildMenuItem(
                      icon: Icons.home,
                      label: 'Home',
                      isSelected: _selectedIndex == 0,
                      onTap: () => switchToSection(0, false),
                    ),
                    _buildExpansionTile(
                      icon: Icons.person_2_outlined,
                      label: 'Clients',
                      isSelected: _selectedIndex >= 1 && _selectedIndex <= 3,
                      children: [
                        _buildMenuItem(
                          icon: null,
                          label: 'Approved',
                          isSelected: _selectedIndex == 1,
                          onTap: () => switchToSection(1, true),
                        ),
                        _buildMenuItem(
                          icon: null,
                          label: 'Pending',
                          isSelected: _selectedIndex == 2,
                          onTap: () => switchToSection(2, true),
                        ),
                        _buildMenuItem(
                          icon: null,
                          label: 'Rejected',
                          isSelected: _selectedIndex == 3,
                          onTap: () => switchToSection(3, true),
                        ),
                      ],
                    ),
                    _buildExpansionTile(
                      icon: Icons.person_outline,
                      label: 'Employees',
                      isSelected: _selectedIndex >= 1 && _selectedIndex <= 3,
                      children: [
                        _buildMenuItem(
                          icon: null,
                          label: 'Approved',
                          isSelected: _selectedIndex == 1,
                          onTap: () => switchToSection(1, false),
                        ),
                        _buildMenuItem(
                          icon: null,
                          label: 'Pending',
                          isSelected: _selectedIndex == 2,
                          onTap: () => switchToSection(2, false),
                        ),
                        _buildMenuItem(
                          icon: null,
                          label: 'Rejected',
                          isSelected: _selectedIndex == 3,
                          onTap: () => switchToSection(3, false),
                        ),
                      ],
                    ),
                    _buildMenuItem(
                      icon: Icons.person_2_rounded,
                      label: 'Event Manager',
                      isSelected: _selectedIndex == 6,
                      onTap: () => switchToSection(6, false),
                    ),
                    _buildMenuItem(
                      icon: Icons.person_2_sharp,
                      label: 'Finance Manager',
                      isSelected: _selectedIndex == 7,
                      onTap: () => switchToSection(7, false),
                    ),
                    _buildMenuItem(
                      icon: Icons.emoji_people_rounded,
                      label: 'Partners',
                      isSelected: _selectedIndex == 11,
                      onTap: () => switchToSection(11, false),
                    ),
                    _buildMenuItem(
                      icon: Icons.local_shipping,
                      label: 'Logistics',
                      isSelected: _selectedIndex == 10,
                      onTap: () => switchToSection(10, false),
                    ),
                    _buildMenuItem(
                      icon: Icons.rate_review,
                      label: 'Feedbacks',
                      isSelected: _selectedIndex == 8,
                      onTap: () => switchToSection(8, false),
                    ),
                    _buildMenuItem(
                      icon: Icons.reviews_outlined,
                      label: 'Ratings',
                      isSelected: _selectedIndex == 12,
                      onTap: () => switchToSection(12, false),
                    ),
                    _buildMenuItem(
                      icon: Icons.settings,
                      label: 'Settings',
                      isSelected: _selectedIndex == 9,
                      onTap: () => switchToSection(9, false),
                    ),
                    _buildMenuItem(
                      icon: Icons.logout_rounded,
                      label: 'Logout',
                      isSelected: false,
                      color: Colors.red,
                      onTap: () {
                        AuthService().signOut();
                      },
                    ),
                  ],
                ),
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

  Widget _buildMenuItem({
    required IconData? icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    Color color = Colors.white,
  }) {
    return ListTile(
      leading: icon != null ? Icon(icon, color: isSelected ? Colors.blue : color) : null,
      title: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.blue : color,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      tileColor: isSelected ? Colors.blueGrey[700] : Colors.blueGrey[900],
      onTap: onTap,
    );
  }

  Widget _buildExpansionTile({
    required IconData icon,
    required String label,
    required bool isSelected,
    required List<Widget> children,
  }) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
      ),
      child: ExpansionTile(
        leading: Icon(icon, color: isSelected ? Colors.blue : Colors.white),
        title: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.blue : Colors.white,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        children: children,
        backgroundColor: Colors.blueGrey[900],
        collapsedBackgroundColor: Colors.blueGrey[900],
        collapsedIconColor: Colors.white,
        iconColor: Colors.blue,
      ),
    );
  }
}
