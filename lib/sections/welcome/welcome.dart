import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hikers_dash/sections/welcome/info_tile.dart';
import 'package:hikers_dash/services/database.dart';
import 'package:hikers_dash/services/models/client.dart';
// ignore: unused_import
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const SearchBar({
    Key? key,
    required this.controller,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
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
  // ignore: unused_field
  late List<Client> _clients;
  late List<Map<String, dynamic>> _feedbackList;
  late List<Map<String, dynamic>> _filteredFeedbackList;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _clients = [];
    _feedbackList = [];
    _filteredFeedbackList = [];
    _loadData();
  }

  void _loadData() async {
    List<Client> clients = await Database.getClients();
    List<Map<String, dynamic>>? feedbackList = [];

    // Fetch feedback from Firestore
    QuerySnapshot feedbackSnapshot =
        await FirebaseFirestore.instance.collection('feedback').get();

    feedbackList = feedbackSnapshot.docs.map((doc) => doc.data()).cast<Map<String, dynamic>>().toList();

    setState(() {
      _clients = clients;
      _feedbackList = feedbackList!;
      _filteredFeedbackList = feedbackList;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _perfomSearch(String query) {
    setState(() {
      _filteredFeedbackList = _feedbackList
          .where((feedback) =>
              feedback['feedback'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
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
                        _perfomSearch(value);
                      },
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 50),
            Expanded(
              child: FutureBuilder<List<Client>>(
                future: Database.getClients(),
                initialData: [],
                builder: (context, snapshot) {
                  final clients = snapshot.data;
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("Something happened ${snapshot.error}"),
                    );
                  } else if (snapshot.hasData && snapshot.data != null) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InfoTile(
                              title: 'Verified users',
                              stat: clients!
                                  .where(
                                      (client) => client.status == 'Verified')
                                  .length,
                              icon: Icons.group_add_rounded,
                            ),
                            SizedBox(width: 10),
                            InfoTile(
                              title: 'Users awaiting verification',
                              stat: clients
                                  .where((client) =>
                                      !(client.status == 'Verified'))
                                  .length,
                              icon: Icons.question_mark,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FutureBuilder<int>(
                              future: Database.getNumberOfEvents(),
                              initialData: 0,
                              builder: (context, snapshot) {
                                final events = snapshot.data!;
                                return InfoTile(
                                  title: 'Number of events',
                                  stat: events,
                                  icon: Icons.event,
                                );
                              },
                            ),
                            SizedBox(width: 10),
                            FutureBuilder<int>(
                              future: Database.getTotalRevenue(),
                              initialData: 0,
                              builder: (context, snapshot) {
                                final income = snapshot.data!;
                                return InfoTile(
                                  title: 'Income generated',
                                  stat: income,
                                  icon: Icons.money_rounded,
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Expanded(
                          child: ListView.builder(
                            itemCount: _filteredFeedbackList.length,
                            itemBuilder: (context, index) {
                              var feedback = _filteredFeedbackList[index];
                              var timestamp = feedback['timestamp']?.toDate();
                              var message = feedback['feedback'];
                              var name = feedback['clientName'];

                              return ListTile(
                                title: Text('Time: ${timestamp ?? 'N/A'}'),
                                subtitle: Text('Client: ${name ?? 'N/A'}'),
                                trailing: Text('Feedback: ${message ?? 'N/A'}'),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }
                  return Center(child: Text("No checks hit"));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
