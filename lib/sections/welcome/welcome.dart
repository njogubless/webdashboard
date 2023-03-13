import 'package:flutter/material.dart';
import 'package:hikers_dash/services/database.dart';
import 'package:hikers_dash/services/models/client.dart';

class WelcomeSection extends StatefulWidget {
  const WelcomeSection({
    super.key,
    required this.switchPage,
  });

  final Function(int index) switchPage;

  @override
  State<WelcomeSection> createState() => _WelcomeSectionState();
}

class _WelcomeSectionState extends State<WelcomeSection> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: 500,
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 50),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome to HikersAfrique',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                ),
              ),
              SizedBox(height: 50),
              FutureBuilder<List<Client>>(
                  future: Database.getClients(),
                  initialData: [],
                  builder: (context, snapshot) {
                    final clients = snapshot.data;
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'House keeping',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                            'Verified users: ${clients!.where((client) => client.verified).length}'),
                        Text(
                            'Users awaiting verification: ${clients.where((client) => !client.verified).length}'),
                      ],
                    );
                  }),
              SizedBox(height: 20),
              MaterialButton(
                onPressed: () => widget.switchPage(1),
                color: Colors.blue,
                elevation: 3.0,
                child: const Center(
                  child: Text(
                    'Verify users',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'),
                  ),
                ),
              ),
              SizedBox(height: 20),
              MaterialButton(
                onPressed: () => widget.switchPage(2),
                color: Colors.blue,
                elevation: 3.0,
                child: const Center(
                  child: Text(
                    'Add events',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'),
                  ),
                ),
              ),
              SizedBox(height: 20),
              MaterialButton(
                onPressed: () => widget.switchPage(3),
                color: Colors.blue,
                elevation: 3.0,
                child: const Center(
                  child: Text(
                    'Manage events',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'),
                  ),
                ),
              ),
              SizedBox(height: 20),
              MaterialButton(
                onPressed: () => widget.switchPage(4),
                color: Colors.blue,
                elevation: 3.0,
                child: const Center(
                  child: Text(
                    'See booked events',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
