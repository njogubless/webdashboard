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
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.grey[200],
      ),
      child:TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: 'Search here ...',
          prefixIcon: Icon(Icons.search),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 14.0),
          )
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
    List<Payment> fetchedPayments = await Database.getrecordPayments();
    setState(() {
      allPayments = fetchedPayments;
      filteredPayments = allPayments;
    });
  }

  void _searchPayments(String searchText) {
    setState(() {
      filteredPayments = allPayments
          .where((payment) =>
              payment.clientName
                  .toLowerCase()
                  .contains(searchText.toLowerCase()) ||
              payment.email.toLowerCase().contains(searchText.toLowerCase()) ||
              payment.event.toLowerCase().contains(searchText.toLowerCase()) ||
              payment.mpesaCode
                  .toLowerCase()
                  .contains(searchText.toLowerCase()) ||
              payment.status.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.only(
            top: 20, left: 50, right: 50), // Adjust the padding as needed
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
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search payments...',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    _searchPayments(searchController.text);
                  },
                ),
              ),
            ),
            FutureBuilder<List<Payment>>(
              future: Database.getrecordPayments(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
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
                      rows: filteredPayments.map((payment) {
                        return DataRow(cells: [
                          DataCell(
                              Text('${filteredPayments.indexOf(payment) + 1}')),
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
