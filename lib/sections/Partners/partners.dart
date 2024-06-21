import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.grey[200],
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: 'Search partnerships...',
          prefixIcon: Icon(Icons.search),
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 10.0, vertical: 14.0),
        ),
      ),
    );
  }
}

class PartnersPage extends StatefulWidget {
  const PartnersPage({Key? key}) : super(key: key);

  @override
  State<PartnersPage> createState() => _PartnersPageState();
}

class _PartnersPageState extends State<PartnersPage> {
  TextEditingController searchController = TextEditingController();
  List<DocumentSnapshot> allPartnerships = [];
  List<DocumentSnapshot> filteredPartnerships = [];

  @override
  void initState() {
    super.initState();
    fetchPartnerships();
  }

  Future<void> fetchPartnerships() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('partnerships').get();
 
      setState(() {
        allPartnerships = querySnapshot.docs;
        filteredPartnerships = allPartnerships;
      });
    } catch (e) {
      // Handle any errors that might occur
      print("Error fetching partnerships data: $e");
    }
  }

  void _searchPartnerships(String searchText) {
    String searchLower = searchText.toLowerCase().trim();

    setState(() {
      filteredPartnerships = allPartnerships.where((partner) {
        Map<String, dynamic> data = partner.data() as Map<String, dynamic>;

        String eventName = (data['eventName'] ?? '').toString().toLowerCase();
        String partnerName = (data['partnerName'] ?? '').toString().toLowerCase();
        String partnerType = (data['partnerType'] ?? '').toString().toLowerCase();
        String amountOffered = (data['amountOffered'] ?? '').toString().toLowerCase();

        return eventName.contains(searchLower) ||
               partnerName.contains(searchLower) ||
               partnerType.contains(searchLower) ||
               amountOffered.contains(searchLower);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Partnerships',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SearchBar(
              controller: searchController,
              onChanged: (value) {
                _searchPartnerships(value);
              },
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: MaterialStateColor.resolveWith(
                    (states) => const Color.fromARGB(255, 64, 181, 240)),
                columns: const [
                  DataColumn(label: Text('Event Name')),
                  DataColumn(label: Text('Partner Name')),
                  DataColumn(label: Text('Partner Type')),
                  DataColumn(label: Text('Amount Offered')),
                ],
                rows: filteredPartnerships.map((partner) {
                  Map<String, dynamic> partnerData =
                      partner.data() as Map<String, dynamic>;
                  String partnerType = partnerData['partnerType'];
                  String amountOffered = partnerType == 'Sponsor'
                      ? partnerData['amountOffered'] ?? 'N/A'
                      : 'N/A'; // Show amount only for sponsors

                  return DataRow(cells: [
                    DataCell(Text(partnerData['eventName'] ?? '')),
                    DataCell(Text(partnerData['partnerName'] ?? '')),
                    DataCell(Text(partnerData['partnerType'] ?? '')),
                    DataCell(Text(amountOffered)),
                  ]);
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
