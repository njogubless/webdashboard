import 'package:flutter/material.dart';
import 'package:hikers_dash/services/database.dart';
import 'package:hikers_dash/services/models/booking.dart';
import 'package:url_launcher/url_launcher.dart';

class BookedEvents extends StatelessWidget {
  const BookedEvents({super.key});

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
              'Booked Events',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 50,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 30),
            FutureBuilder<List<BookedEventItem>>(
              future: Database.getBookedEvents(),
              initialData: const [],
              builder: (context, snapshot) {
                final bookedEvents = snapshot.data!;
                return DataTable(
                  columns: [
                    DataColumn(
                      label: Text('#'),
                    ),
                    DataColumn(
                      label: Text('Event Name'),
                    ),
                    DataColumn(
                      label: Text('User Name'),
                    ),
                    DataColumn(
                      label: Text('User Email'),
                    ),
                    DataColumn(
                      label: Text('Date Booked'),
                    ),
                    DataColumn(
                      label: Text('Reach out'),
                    ),
                  ],
                  rows: [
                    for (final event in bookedEvents)
                      DataRow(
                        cells: [
                          DataCell(Text('${bookedEvents.indexOf(event) + 1}')),
                          DataCell(Text(event.eventName)),
                          DataCell(Text(event.userName)),
                          DataCell(Text(event.userEmail)),
                          DataCell(Text(event.bookingDate.substring(0, 10))),
                          DataCell(
                            IconButton(
                              onPressed: () {
                                final Uri emailLaunchUri = Uri(
                                  scheme: 'mailto',
                                  path: event.userEmail,
                                  query: encodeQueryParameters(<String, String>{
                                    'subject': 'RE: ${event.eventName}',
                                  }),
                                );

                                launchUrl(emailLaunchUri);
                              },
                              icon: const Icon(
                                Icons.email,
                                color: Colors.blue,
                              ),
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

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }
}
