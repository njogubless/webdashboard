import 'package:flutter/material.dart';
import 'package:hikers_dash/services/database.dart';
import 'package:hikers_dash/services/models/payment.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const SearchBar({
    Key? key,
    required this.controller,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.grey[200],
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: 'Search here...',
          prefixIcon: Icon(Icons.search),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 14.0),
        ),
      ),
    );
  }
}

class BookedEvents extends StatefulWidget {
  const BookedEvents({Key? key}) : super(key: key);

  @override
  _BookedEventsState createState() => _BookedEventsState();
}

class _BookedEventsState extends State<BookedEvents> {
  TextEditingController searchController = TextEditingController();
  List<Payment> allPayments = [];
  List<Payment> filteredPayments = [];

  @override
  void initState() {
    super.initState();
    _loadPayments();
  }

  void _loadPayments() async {
    try {
      List<Payment> fetchedPayments = await Database.getrecordPayments();
      setState(() {
        allPayments = fetchedPayments;
        filteredPayments = allPayments;
      });
      print('Payments loaded: ${allPayments.length}');
    } catch (e) {
      print('Error loading payments: $e');
    }
  }

  void _searchPayments(String searchText) {
    setState(() {
      filteredPayments = allPayments.where((payment) {
        final paymentString = '${payment.clientName} ${payment.email} ${payment.event} ${payment.mpesaCode} ${payment.status}'.toLowerCase();
        return paymentString.contains(searchText.toLowerCase());
      }).toList();
      print('Filtered payments: ${filteredPayments.length}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
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
            SearchBar(
              controller: searchController,
              onChanged: (value) {
                _searchPayments(value);
              },
            ),
            const SizedBox(height: 30),
            if (filteredPayments.isEmpty)
              Center(child: Text('No matching results found'))
            else
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('UID')),
                    DataColumn(label: Text('Client Name')),
                    DataColumn(label: Text('Client Email')),
                    DataColumn(label: Text('Event')),
                    DataColumn(label: Text('M-Pesa Code')),
                    DataColumn(label: Text('Total Cost (Ksh)')),
                    //DataColumn(label: Text('Status')),
                    DataColumn(label: Text('Action')),
                  ],
                  rows: filteredPayments.map((payment) {
                    return DataRow(cells: [
                       DataCell(Text(payment.id)),
                      //DataCell(Text('${filteredPayments.indexOf(payment) + 1}')),
                      DataCell(Text(payment.clientName)),
                      DataCell(Text(payment.email)),
                      DataCell(Text(payment.event)),
                      DataCell(Text(payment.mpesaCode)),
                      DataCell(Text('${payment.totalCost}')),
                      //DataCell(Text(payment.status ?? 'Unknown')),
                      DataCell(
                        IconButton(
                          onPressed: () {
                            final Uri emailLaunchUri = Uri(
                              scheme: 'mailto',
                              path: payment.email,
                              query: encodeQueryParameters({'subject': 'RE: ${payment.event}'}),
                            );
                            launchUrl(emailLaunchUri);
                          },
                          icon: const Icon(Icons.email, color: Colors.blue),
                        ),
                      ),
                    ]);
                  }).toList(),
                ),
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
        .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }
}
