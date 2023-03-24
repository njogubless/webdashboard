import 'package:flutter/material.dart';
import 'package:hikers_dash/services/database.dart';
import 'package:hikers_dash/services/models/event.dart';

class ManageEvents extends StatefulWidget {
  const ManageEvents({super.key});

  @override
  State<ManageEvents> createState() => _ManageEventsState();
}

class _ManageEventsState extends State<ManageEvents> {
  void refresh() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 50),
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
              return DataTable(
                columns: [
                  DataColumn(
                    label: Text('#'),
                  ),
                  DataColumn(
                    label: Text('Event Name'),
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
                        DataCell(Text('${event.eventCost}')),
                        DataCell(Text(event.eventDate)),
                        DataCell(Text(event.eventTime)),
                        DataCell(
                          IconButton(
                            onPressed: () async {
                              Database.deleteEvent(event);
                              refresh();
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Event deleted!'),
                                behavior: SnackBarBehavior.floating,
                              ));
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
              );
            },
          ),
        ],
      ),
    );
  }
}

class AvailableEvent extends StatelessWidget {
  const AvailableEvent({
    super.key,
    required this.event,
    required this.refresh,
  });

  final Event event;
  final VoidCallback refresh;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: IconButton(
          onPressed: () async {
            Database.deleteEvent(event);
            refresh();
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Event deleted!'),
              behavior: SnackBarBehavior.floating,
            ));
          },
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          )),
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
            event.eventLocation,
            style: const TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 20,
            ),
          ),
          Text(
            event.eventDate,
            style: const TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 20,
            ),
          ),
          Text(
            event.eventTime,
            style: const TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 20,
            ),
          ),
          Text(
            'Ksh. ${event.eventCost}',
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
