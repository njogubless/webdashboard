import 'package:flutter/material.dart';
import 'package:hikers_dash/services/database.dart';
import 'package:hikers_dash/services/models/booking.dart';
import 'package:url_launcher/url_launcher.dart';

class BookedEvents extends StatelessWidget {
  const BookedEvents({super.key});

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
              'Booked Events',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 50,
              ),
            ),
            const SizedBox(height: 30),
            FutureBuilder<List<Booking>>(
              future: Database.getBookedEvents(),
              initialData: const [],
              builder: (context, snapshot) {
                final events = snapshot.data;
                return SizedBox(
                  height: 400,
                  child: ListView.builder(
                      itemCount: events!.length,
                      itemBuilder: (context, index) {
                        return BookedEvent(event: events[index]);
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

class BookedEvent extends StatelessWidget {
  const BookedEvent({
    super.key,
    required this.event,
  });

  final Booking event;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: IconButton(
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
          )),
      title: Text(
        event.userEmail,
        style: const TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 20,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            event.eventName,
            style: const TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 20,
            ),
          ),
          Text(
            'Booked on: ${event.bookingDate.substring(0, 10)}',
            style: const TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 20,
            ),
          ),
        ],
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
