import 'package:flutter/material.dart';
import 'package:hikers_dash/services/database.dart';
import 'package:hikers_dash/services/models/payment.dart';
import 'package:url_launcher/url_launcher.dart';

class BookedEvents extends StatelessWidget {
  const BookedEvents({Key? key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 50, right: 50), // Adjust the padding as needed
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Finance Details',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 50,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 30),
            FutureBuilder<List<Payment>>(
              future: Database.getrecordPayments(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final List<Payment> payments = snapshot.data!;
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: [
                        DataColumn(label: Text('#')),
                        DataColumn(label: Text('Client Name')),
                        DataColumn(label: Text('Client Email')),
                        DataColumn(label: Text('Event')),
                        DataColumn(label: Text('M-Pesa Code')),
                        DataColumn(label: Text('Total Cost (Ksh)')),
                        DataColumn(label: Text('Status')),
                        DataColumn(label: Text('Action')),
                      ],
                      rows: payments.map((payment) {
                        return DataRow(cells: [
                          DataCell(Text('${payments.indexOf(payment) + 1}')),
                          DataCell(Text(payment.clientName)),
                          DataCell(Text(payment.email)),
                          DataCell(Text(payment.event)),
                          DataCell(Text(payment.mpesaCode)),
                          DataCell(Text('${payment.totalCost}')),
                          DataCell(
                            Text(
                              payment.status ?? 'Unknown',
                            ),
                          ),
                          DataCell(
                            IconButton(
                              onPressed: () {
                                final Uri emailLaunchUri = Uri(
                                  scheme: 'mailto',
                                  path: payment.email,
                                  query: encodeQueryParameters(
                                    {'subject': 'RE: ${payment.event}'},
                                  ),
                                );
                                launchUrl(emailLaunchUri);
                              },
                              icon: const Icon(
                                Icons.email,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ]);
                      }).toList(),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void launchUrl(Uri uri) async {
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      throw 'Could not launch $uri';
    }
  }

  String encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }
}
