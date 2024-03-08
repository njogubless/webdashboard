import 'package:flutter/material.dart';

class LogisticsPage extends StatefulWidget {
  final String eventName;
  final String eventDate;
  final String driverName;
  final String guideName;

  const LogisticsPage({
    Key? key,
    required this.eventName,
    required this.eventDate,
    required this.driverName,
    required this.guideName,
  }) : super(key: key);

  @override
  _LogisticsPageState createState() => _LogisticsPageState();
}

class _LogisticsPageState extends State<LogisticsPage> {
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
                      headingRowColor: MaterialStateColor.resolveWith(
                          (states) => Colors.blueGrey),
                      columns: [
                        DataColumn(label: Text('EventName')),
                        DataColumn(label: Text('EventDate')),
                        DataColumn(label: Text('DriverName')),
                        DataColumn(label: Text('GuideName')),
                      ],
                      rows: [
                        DataRow(cells: [
                          DataCell(
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(widget.eventName),
                            ),
                          ),
                          DataCell(
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(widget.eventDate),
                            ),
                          ),
                          DataCell(
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(widget.driverName),
                            ),
                          ),
                          DataCell(
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(widget.guideName),
                            ),
                          ),
                        ]),
                        DataRow(cells: [
                          DataCell(
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text('Event2'),
                            ),
                          ),
                          DataCell(
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text('Date2'),
                            ),
                          ),
                          DataCell(
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text('Driver2'),
                            ),
                          ),
                          DataCell(
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text('Guide2'),
                            ),
                          ),
                        ]),
                        DataRow(cells: [
                          DataCell(
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text('Event3'),
                            ),
                          ),
                          DataCell(
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text('Date3'),
                            ),
                          ),
                          DataCell(
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text('Driver3'),
                            ),
                          ),
                          DataCell(
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text('Guide3'),
                            ),
                          ),
                        ]),
                      ],
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
