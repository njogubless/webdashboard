import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PartnersPage extends StatelessWidget {
  const PartnersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Partnerships',
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),),
        
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('partnerships').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final List<DocumentSnapshot> partnerships = snapshot.data!.docs;
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: MaterialStateColor.resolveWith(
                          (states) => const Color.fromARGB(255, 64, 181, 240)),
                columns: const [
                  DataColumn(label: Text('Event Name')),
                  DataColumn(label: Text('Partner Name')),
                  DataColumn(label: Text('Partner Type')),
                ],
                rows: partnerships.map((partner) {
                  Map<String, dynamic> partnerData = partner.data() as Map<String, dynamic>;
                  return DataRow(cells: [
                    DataCell(Text(partnerData['eventName'] ?? 'N/A' )),
                    DataCell(Text(partnerData['partnerName'] ?? 'N/A')),
                    DataCell(Text(partnerData['partnerType'] ?? 'N/A')),
                  ]);
                }).toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
