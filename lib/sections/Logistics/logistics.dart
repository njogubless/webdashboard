import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hikers_dash/services/models/logistics.dart';

class LogisticsPage extends StatelessWidget {
  final List<LogisticsData> logisticsData;

  const LogisticsPage({Key? key, required this.logisticsData}) : super(key: key);

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
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      headingRowColor:
                          MaterialStateColor.resolveWith((states) => Colors.blueGrey),
                      columns: [
                        DataColumn(label: Text('Event Name')),
                        DataColumn(label: Text('Driver')),
                        DataColumn(label: Text('Guide')),
                      ],
                      rows: logisticsData.map((data) {
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

      List<LogisticsData> tempData = [];

      querySnapshot.docs.forEach((doc) {
        tempData.add(LogisticsData(
          eventName: doc['event'] ?? '',
          driver: doc['driver'] ?? '',
          guide: doc['guide'] ?? '',
        ));
      });

      setState(() {
        logisticsData = tempData;
      });
    } catch (e) {
      // Handle any errors that might occur
      print("Error fetching logistics data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return LogisticsPage(logisticsData: logisticsData);
  }
}
