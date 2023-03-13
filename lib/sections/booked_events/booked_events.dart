import 'package:flutter/material.dart';
import 'package:hikers_dash/services/database.dart';
import 'package:hikers_dash/services/models/booking.dart';

class BookedEvents extends StatelessWidget {
  const BookedEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Padding(
        padding: const EdgeInsets.only(top: 20, left: 50),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
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
                return ListView.builder(itemBuilder: (context, index) {
                  return BookedEvent(event: events![index]);
                });
              },
            ),
          ],
        ),
      ),
    ]);
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
      title: Text(
        event.eventName,
        style: const TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 30,
        ),
      ),
      subtitle: Column(
        children: [
          Text(
            event.userEmail,
            style: const TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 20,
            ),
          ),
          Text(
            'Booking date: ${event.bookingDate}',
            style: const TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
