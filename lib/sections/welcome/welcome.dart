import 'package:flutter/material.dart';
import 'package:hikers_dash/sections/welcome/info_tile.dart';
import 'package:hikers_dash/services/database.dart';
import 'package:hikers_dash/services/models/client.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const SearchBar({
    Key? key,
    required this.controller,
    required this.onChanged,
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
          hintText: 'Search here...',
          prefixIcon: Icon(Icons.search),
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 10.0, vertical: 14.0),
        ),
      ),
    );
  }
}

class WelcomeSection extends StatefulWidget {
  const WelcomeSection({
    Key? key,
    required this.switchPage,
  }) : super(key: key);

  final Function(int index, bool isClient) switchPage;

  @override
  State<WelcomeSection> createState() => _WelcomeSectionState();
}

class _WelcomeSectionState extends State<WelcomeSection> {
  late TextEditingController _searchController;
  late List<Client> _clients;
  late List<Client> _filteredClients;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _clients = [];
    _filteredClients = [];
    _loadData();
  }

  void _loadData() async {
    List<Client> clients = await Database.getClients();

    setState(() {
      _clients = clients;
      _filteredClients = clients;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HikersAfrique Admin Panel'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Welcome to HikersAfrique Admin Panel',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                    color: Colors.indigo,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.search),
                    SizedBox(width: 10),
                    SearchBar(
                      controller: _searchController,
                      onChanged: (value) {
                        _performSearch(value);
                      },
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            // Display search results
            if (_searchController.text.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: _filteredClients.length,
                  itemBuilder: (context, index) {
                    var client = _filteredClients[index];
                    var name = client.clientName;

                    return ListTile(
                      title: Text('USER: ${name}'),
                      subtitle: Text(
                          'Status: ${client.status},Role: ${client.role}'),
                    );
                  },
                ),
              ),
            SizedBox(height: 20),
            // Other widgets below
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InfoTile(
                  title: 'Verified users',
                  stat: _clients!
                      .where((client) => client.status == 'Verified')
                      .length,
                  icon: Icons.person,
                  iconColor: Colors.white,
                ),
                SizedBox(width: 10),
                InfoTile(
                  title: 'Users awaiting verification',
                  stat: _clients
                      .where((client) => !(client.status == 'Verified'))
                      .length,
                  icon: Icons.person_outline,
                  iconColor: Colors.white,
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(
                  child: FutureBuilder<int>(
                    future: Database.getNumberOfEvents(),
                    initialData: 0,
                    builder: (context, snapshot) {
                      final events = snapshot.data ?? 0;
                      return InfoTile(
                        title: 'Number of events',
                        stat: events,
                        icon: Icons.event,
                        iconColor: Colors.white,
                      );
                    },
                  ),
                ),
                SizedBox(width: 10),
                FittedBox(
                  child: FutureBuilder<int>(
                    future: Database.getTotalRevenue(),
                    initialData: 0,
                    builder: (context, snapshot) {
                      final income = snapshot.data ?? 0;
                      return InfoTile(
                        title: 'Income generated',
                        stat: income,
                        icon: Icons.attach_money,
                        iconColor: Colors.white,
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: WelcomeSection(
      switchPage: (index, isClient) {},
    ),
  ));
}
