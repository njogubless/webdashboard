import 'package:flutter/material.dart';
import 'package:hikers_dash/services/database.dart';
import 'package:hikers_dash/services/models/client.dart';

class VerifyUsers extends StatefulWidget {
  const VerifyUsers({super.key});

  @override
  State<VerifyUsers> createState() => _VerifyUsersState();
}

class _VerifyUsersState extends State<VerifyUsers> {
  void refresh() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: 500,
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 50),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              'Pending Verification',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 50,
              ),
            ),
            const SizedBox(height: 30),
            FutureBuilder<List<Client>>(
              future: Database.getPendingClients(),
              initialData: const [],
              builder: (context, snapshot) {
                final clients = snapshot.data;
                return clients!.isEmpty
                    ? const Text('No pending verifications')
                    : SizedBox(
                        height: 400,
                        child: ListView.builder(
                            itemCount: clients.length,
                            itemBuilder: (context, index) {
                              return PendingUserTile(
                                client: clients[index],
                                refresh: refresh,
                              );
                            }),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PendingUserTile extends StatelessWidget {
  const PendingUserTile({
    super.key,
    required this.client,
    required this.refresh,
  });

  final Client client;
  final VoidCallback refresh;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: TextButton(
        onPressed: () async {
          await Database.verifyser(client);
          refresh();
        },
        child: const Text('Verify user'),
      ),
      title: Text(
        client.clientEmail,
        style: const TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 20,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Not verified',
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
