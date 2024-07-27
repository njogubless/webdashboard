import 'package:flutter/material.dart';
import 'package:hikers_dash/services/database.dart';
import 'package:hikers_dash/services/models/client.dart';

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
  late List<Client> _clients;

  @override
  void initState() {
    super.initState();
    _clients = [];
    _loadData();
  }

  void _loadData() async {
    List<Client> clients = await Database.getClients();

    setState(() {
      _clients = clients;
    });
  }

  @override
  void dispose() {
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
            Text(
              'Welcome to HikersAfrique Admin Panel',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: Colors.indigo,
              ),
            ),
            SizedBox(height: 20),
            // Other widgets below
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InfoTile(
                  title: 'Verified users',
                  stat: _clients
                      .where((client) => client.status == 'Verified')
                      .length,
                  icon: Icons.person,
                  iconColor: Colors.white,
                  backgroundColor: Colors.deepPurpleAccent,
                ),
                SizedBox(width: 10),
                InfoTile(
                  title: 'Users awaiting verification',
                  stat: _clients
                      .where((client) => !(client.status == 'Verified'))
                      .length,
                  icon: Icons.person_outline,
                  iconColor: Colors.white,
                  backgroundColor: Colors.deepOrangeAccent,
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
                        backgroundColor: Colors.blueAccent,
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
                        backgroundColor: Colors.greenAccent,
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

class InfoTile extends StatelessWidget {
  final String title;
  final int stat;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;

  const InfoTile({
    Key? key,
    required this.title,
    required this.stat,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 50, color: iconColor),
          SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            stat.toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
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
