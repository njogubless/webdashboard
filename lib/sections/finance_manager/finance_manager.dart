import 'package:flutter/material.dart';

class Transaction {
  final String customerName;
  final String event;
  final double amount;
  final DateTime timePaid;

  Transaction({
    required this.customerName,
    required this.event,
    required this.amount,
    required this.timePaid,
  });
}

class FinanceManagerPage extends StatefulWidget {
  @override
  _FinanceManagerPageState createState() => _FinanceManagerPageState();
}

class _FinanceManagerPageState extends State<FinanceManagerPage> {
  final List<Transaction> transactions = [
    Transaction(
      customerName: 'John Doe',
      event: 'Hiking Adventure',
      amount: 50.0,
      timePaid: DateTime.now(),
    ),
    Transaction(
      customerName: 'Jane Smith',
      event: 'Camping Trip',
      amount: 80.0,
      timePaid: DateTime.now(),
    ),
    Transaction(
      customerName: 'Mike Johnson',
      event: 'Nature Walk',
      amount: 30.0,
      timePaid: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Finance Manager'),
      ),
      body: DataTable(
        columns: const [
          DataColumn(
            label: Text('Customer Name'),
          ),
          DataColumn(
            label: Text('Event'),
          ),
          DataColumn(
            label: Text('Amount'),
          ),
          DataColumn(
            label: Text('Time Paid'),
          ),
        ],
        rows: transactions.map((transaction) {
          return DataRow(
            cells: [
              DataCell(Text(transaction.customerName)),
              DataCell(Text(transaction.event)),
              DataCell(Text(transaction.amount.toString())),
              DataCell(Text(transaction.timePaid.toString())),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class AdminHomePage extends StatefulWidget {
  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  String _selectedMenuItem = 'Finance Manager';
  Widget _selectedPage = FinanceManagerPage();

  void _onMenuItemSelected(String value) {
    setState(() {
      _selectedMenuItem = value;
      if (_selectedMenuItem == 'Finance Manager') {
        _selectedPage = FinanceManagerPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body: Row(
        children: [
          NavigationRail(
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.person_outline),
                label: Text('Finance Manager'),
              ),
            ],
            selectedIndex: 0,
            onDestinationSelected: (int index) {
              _onMenuItemSelected('Finance Manager');
            },
          ),
          VerticalDivider(),
          Expanded(
            child: _selectedPage,
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Admin Interface',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: AdminHomePage(),
  ));
}
