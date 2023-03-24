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
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 50),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'HikersAfrique Users',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 50,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 30),
            FutureBuilder<List<Client>>(
              future: Database.getClients(),
              initialData: const [],
              builder: (context, snapshot) {
                final clients = snapshot.data!;
                return DataTable(
                  columns: [
                    DataColumn(
                      label: Text('#'),
                    ),
                    DataColumn(
                      label: Text('Name'),
                    ),
                    DataColumn(
                      label: Text('Email'),
                    ),
                    DataColumn(
                      label: Text('Role'),
                    ),
                    DataColumn(
                      label: Text('Status'),
                    ),
                    DataColumn(
                      label: Text('Action'),
                    ),
                  ],
                  rows: [
                    for (final client in clients)
                      DataRow(
                        cells: [
                          DataCell(Text('${clients.indexOf(client) + 1}')),
                          DataCell(Text(client.clientName)),
                          DataCell(Text('${client.clientEmail}')),
                          DataCell(Text('${client.role}')),
                          DataCell(Text('${client.status}')),
                          DataCell(
                            UserActionButton(
                              client: client,
                              refresh: refresh,
                            ),
                          )
                        ],
                      )
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class UserActionButton extends StatelessWidget {
  const UserActionButton({
    super.key,
    required this.client,
    required this.refresh,
  });

  final Client client;
  final VoidCallback refresh;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        if (client.status == 'Verified') {
          await Database.revokeUser(client);
        } else {
          await Database.verifyser(client);
        }
        refresh();
      },
      child: Text(
        client.status == 'Verified' ? 'Revoke user' : 'Verify user',
        style: TextStyle(
          color: client.status == 'Verified' ? Colors.red : null,
        ),
      ),
    );
  }
}
