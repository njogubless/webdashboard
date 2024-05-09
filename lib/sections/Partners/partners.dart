import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    setState(() {
      filteredPartnerships = allPartnerships
          .where((partner) =>
              (partner['eventName'] as String)
                  .toLowerCase()
                  .contains(searchText.toLowerCase()) ||
              (partner['partnerName'] as String)
                  .toLowerCase()
                  .contains(searchText.toLowerCase()) ||
              (partner['partnerType'] as String)
                  .toLowerCase()
                  .contains(searchText.toLowerCase()))
          .toList();
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
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search partnerships...',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    _searchPartnerships(searchController.text);
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor:
                    MaterialStateColor.resolveWith((states) => const Color.fromARGB(255, 64, 181, 240)),
                columns: const [
                  DataColumn(label: Text('Event Name')),
                  DataColumn(label: Text('Partner Name')),
                  DataColumn(label: Text('Partner Type')),
                ],
                rows: filteredPartnerships.map((partner) {
                  Map<String, dynamic> partnerData = partner.data() as Map<String, dynamic>;
                  return DataRow(cells: [
                    DataCell(Text(partnerData['eventName'] ?? 'N/A')),
                    DataCell(Text(partnerData['partnerName'] ?? 'N/A')),
                    DataCell(Text(partnerData['partnerType'] ?? 'N/A')),
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