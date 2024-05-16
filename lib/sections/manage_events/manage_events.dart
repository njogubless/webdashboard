import 'package:flutter/material.dart';
import 'package:hikers_dash/services/database.dart';
import 'package:hikers_dash/services/models/event.dart';
import 'package:hikers_dash/services/models/payment.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final List<String> filterOptions;
  final String selectedFilter;
  final Function(String) onSelectedFilter;
  const SearchBar({
    Key? key,
    required this.controller,
    required this.onChanged,
    required this.filterOptions,
    required this.onSelectedFilter,
    required this.selectedFilter,
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
          contentPadding:
              EdgeInsets.symmetric(horizontal: 10.0, vertical: 14.0),
        ),
      ),
    );
  }
}

class ManageEvents extends StatefulWidget {
  const ManageEvents({Key? key}) : super(key: key);

  @override
  State<ManageEvents> createState() => _ManageEventsState();
}

class _ManageEventsState extends State<ManageEvents> {
  List<Payment> payments = [];
  List<Event> events = [];
  List<Event> filteredEvents = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadEvents();
    _loadPayments();
  }

  void _loadEvents() async {
    List<Event> events = await Database.getAvailableEvents();
    setState(() {});
  }

  void _loadPayments() async {
    List<Payment> fetchedPayments = await Database.getrecordPayments();
    List<Event> fetchedEvents = await Database.getAvailableEvents();
    setState(() {
      payments = fetchedPayments;
      events = fetchedEvents;
    });
  }

  void performSearch(String query) {
    setState(() {
      filteredEvents = events.where((event) {
        // Convert all relevant fields to lowercase for case-insensitive search
        final String eventName = event.eventName.toLowerCase();
        final String clientName = _getClientName(event).toLowerCase();
        final String clientEmail = _getClientEmail(event).toLowerCase();
        final String eventCost = event.eventCost.toString().toLowerCase();
        final String eventDate = event.eventDate.toLowerCase();
        final String eventTime = event.eventTime.toLowerCase();

        // Check if any field contains the search query
        return eventName.contains(query.toLowerCase()) ||
            clientName.contains(query.toLowerCase()) ||
            clientEmail.contains(query.toLowerCase()) ||
            eventCost.contains(query.toLowerCase()) ||
            eventDate.contains(query.toLowerCase()) ||
            eventTime.contains(query.toLowerCase());
      }).toList();
    });
  }

  List<Event> searchEvents(String searchText) {
    return events
        .where((event) =>
            event.eventName.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 50),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Manage Events',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 50,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 30),
            FutureBuilder<List<Event>>(
              future: Database.getAvailableEvents(),
              initialData: const [],
              builder: (context, snapshot) {
                final events = snapshot.data!;
                return FittedBox(
                  child: DataTable(
                    columns: [
                      DataColumn(
                        label: Text('#'),
                      ),
                      DataColumn(
                        label: Text('Event Name'),
                      ),
                      DataColumn(
                        label: Text('Client Name'),
                      ),
                      DataColumn(
                        label: Text('Client Email'),
                      ),
                      DataColumn(
                        label: Text('Event Cost (Ksh)'),
                      ),
                      DataColumn(
                        label: Text('Event Date'),
                      ),
                      DataColumn(
                        label: Text('Event Time'),
                      ),
                      DataColumn(
                        label: Text('Action'),
                      ),
                    ],
                    rows: [
                      for (final event in events)
                        DataRow(
                          cells: [
                            DataCell(Text('${events.indexOf(event) + 1}')),
                            DataCell(Text(event.eventName)),
                            DataCell(Text(_getClientName(event))),
                            DataCell(Text(_getClientEmail(event))),
                            DataCell(Text('${event.eventCost}')),
                            DataCell(Text(event.eventDate)),
                            DataCell(Text(event.eventTime)),
                            DataCell(
                              IconButton(
                                onPressed: () async {
                                  _deleteEvent(event);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            )
                          ],
                        )
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  String _getClientName(Event event) {
    Payment payment = _findPaymentForEvent(event);
    return payment.clientName;
  }

  String _getClientEmail(Event event) {
    Payment payment = _findPaymentForEvent(event);
    return payment.email;
  }

  Payment _findPaymentForEvent(Event event) {
    // Find the payment related to the event
    Payment? payment = payments.firstWhere(
      (payment) => payment.event == event.eventName,
      orElse: () => Payment(
          clientName: '',
          amountPaid: 0,
          email: '',
          event: '',
          mpesaCode: '',
          totalCost: 0,
          Status: '',
          id: ''),
    );
    return payment;
  }

  void _deleteEvent(Event event) async {
    await Database.deleteEvent(event);
    _loadPayments();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Event deleted!'),
      behavior: SnackBarBehavior.floating,
    ));
  }
}

class AvailableEvent extends StatelessWidget {
  const AvailableEvent({
    Key? key,
    required this.event,
    required this.clientName,
    required this.clientEmail,
    required this.onDelete,
  }) : super(key: key);

  final Event event;
  final String? clientName;
  final String? clientEmail;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: IconButton(
        onPressed: onDelete,
        icon: const Icon(
          Icons.delete,
          color: Colors.red,
        ),
      ),
      title: Text(
        event.eventName,
        style: const TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 20,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Client Name: ${clientName ?? 'N/A'}',
            style: const TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 20,
            ),
          ),
          Text(
            'Client Email: ${clientEmail ?? 'N/A'}',
            style: const TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 20,
            ),
          ),
          Text(
            'Event Location: ${event.eventLocation}',
            style: const TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 20,
            ),
          ),
          Text(
            'Event Date: ${event.eventDate}',
            style: const TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 20,
            ),
          ),
          Text(
            'Event Time: ${event.eventTime}',
            style: const TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 20,
            ),
          ),
          Text(
            'Event Cost: Ksh. ${event.eventCost}',
            style: const TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
