import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  String bookingDetails = '';
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  void bookAppointment() {
    setState(() {
      String name = nameController.text;
      String date = dateController.text;
      bookingDetails = 'Name: $name\nDate: $date';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: dateController,
              decoration: InputDecoration(
                labelText: 'Date',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: bookAppointment,
              child: Text('Book Appointment'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Booking Details:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(bookingDetails),
          ],
        ),
      ),
    );
  }
}

class ReceiptScreen extends StatelessWidget {
  final String bookingDetails;

  ReceiptScreen({required this.bookingDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Receipt Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Booking Details:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(bookingDetails),
            SizedBox(height: 16.0),
            Text(
              'Payment Details:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            // Add payment details here
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Booking App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => BookingScreen(),
        '/receipt': (context) => ReceiptScreen(
              bookingDetails:
                  ModalRoute.of(context)!.settings.arguments as String,
            ),
      },
    );
  }
}

class Receiptscreen extends StatelessWidget {
  final String bookingDetails;

  Receiptscreen({required this.bookingDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Receipt Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Booking Details:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(bookingDetails),
            SizedBox(height: 16.0),
            Text(
              'Payment Details:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            // Add payment details here

            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                String receiptUrl =
                    'http://example.com/receipt.pdf'; // Replace with your receipt URL
                if (await canLaunchUrl(receiptUrl as Uri)) {
                  await canLaunchUrl(receiptUrl as Uri);
                } else {
                  throw 'Could not launch $receiptUrl';
                }
              },
              child: Text('Download Receipt'),
            ),
          ],
        ),
      ),
    );
  }
}
