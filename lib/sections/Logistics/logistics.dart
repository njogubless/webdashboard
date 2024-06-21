import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hikers_dash/services/models/logistics.dart';

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
          hintText: 'Search logistics...',
          prefixIcon: Icon(Icons.search),
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 10.0, vertical: 14.0),
        ),
      ),
    );
  }
}

class LogisticsPage extends StatefulWidget {
  final List<LogisticsData> logisticsData;

  const LogisticsPage({Key? key, required this.logisticsData})
      : super(key: key);

  @override
  State<LogisticsPage> createState() => _LogisticsPageState();
}

class _LogisticsPageState extends State<LogisticsPage> {
  TextEditingController searchController = TextEditingController();
  List<LogisticsData> filteredLogisticsData = [];

  @override
  void initState() {
    super.initState();
    filteredLogisticsData = widget.logisticsData;
  }

  void _searchLogisticsData(String searchText) {
    setState(() {
      filteredLogisticsData = widget.logisticsData
          .where((data) =>
              data.eventName.toLowerCase().contains(searchText.toLowerCase()) ||
              data.driver.toLowerCase().contains(searchText.toLowerCase()) ||
              data.guide.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logistics Page'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 5,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Logistics Details',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SearchBar(
                    controller: searchController,
                    onChanged: (value) {
                      _searchLogisticsData(value);
                    },
                  ),
                  const SizedBox(height: 20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      headingRowColor: MaterialStateColor.resolveWith(
                          (states) => Colors.blueGrey),
                      columns: [
                        DataColumn(label: Text('Event Name')),
                        DataColumn(label: Text('Driver')),
                        DataColumn(label: Text('Guide')),
                      ],
                      rows: filteredLogisticsData.map((data) {
                        return DataRow(cells: [
                          DataCell(Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(data.eventName),
                          )),
                          DataCell(Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(data.driver),
                          )),
                          DataCell(Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(data.guide),
                          )),
                        ]);
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LogisticsPageScreen extends StatefulWidget {
  @override
  _LogisticsPageScreenState createState() => _LogisticsPageScreenState();
}

class _LogisticsPageScreenState extends State<LogisticsPageScreen> {
  List<LogisticsData> logisticsData = [];

  @override
  void initState() {
    super.initState();
    fetchLogisticsData();
  }

  Future<void> fetchLogisticsData() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('allocations').get();

      List<LogisticsData> tempData = querySnapshot.docs.map((doc) {
        print("Document data: ${doc.data()}"); // Debug log for document data
        return LogisticsData(
          eventName: doc['event'] ?? 'N/A',
          driver: doc['driver'] ?? 'N/A',
          guide: doc['guide'] ?? 'N/A',
        );
      }).toList();

      setState(() {
        logisticsData = tempData;
      });
      print(
          "Logistics data loaded successfully"); // Debug log for successful data load
    } catch (e) {
      // Handle any errors that might occur
      print("Error fetching logistics data: $e"); // Debug log for error
    }
  }

  @override
  Widget build(BuildContext context) {
    return LogisticsPage(logisticsData: logisticsData);
  }
}
