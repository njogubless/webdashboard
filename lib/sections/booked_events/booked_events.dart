import 'package:flutter/material.dart';

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
          children: const [
            Text(
              'Booked Events',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 50,
              ),
            ),
            SizedBox(height: 30),
            
          ],
        ),
      ),
    ]);
  }
}
