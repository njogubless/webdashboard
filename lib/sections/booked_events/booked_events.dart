import 'package:flutter/material.dart';

class BookedEvents extends StatelessWidget {
  const BookedEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SingleChildScrollView(
        child: Column(
          children: const [
            Text('Booked Events'),
          ],
        ),
      ),
    );
  }
}
