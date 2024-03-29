import 'package:flutter/material.dart';
import 'package:hikers_dash/services/database.dart';
import 'package:hikers_dash/services/models/event.dart';
import 'package:uuid/uuid.dart';

class AddEvents extends StatefulWidget {
  const AddEvents({super.key});

  @override
  State<AddEvents> createState() => _AddEventsState();
}

class _AddEventsState extends State<AddEvents> {
  final _formkey = GlobalKey<FormState>();
  final _eventNameController = TextEditingController();
  final _eventDateController = TextEditingController();
  final _eventTimeController = TextEditingController();
  final _eventCostController = TextEditingController();
  final _eventLocationController = TextEditingController();
  final _eventImageUrlController = TextEditingController();
  final _eventtotalCostController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: 500,
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 50),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add Events',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 50,
                  color: Colors.indigo,
                ),
              ),
              Form(
                key: _formkey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _eventNameController,
                      decoration: const InputDecoration(
                          labelText: 'EVENT NAME',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blueAccent))),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                        controller: _eventDateController,
                        decoration: const InputDecoration(
                          labelText: 'EVENT DATE',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blueAccent,
                            ),
                          ),
                        )),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller: _eventTimeController,
                      decoration: const InputDecoration(
                          labelText: 'EVENT TIME',
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blueAccent))),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller: _eventCostController,
                      decoration: const InputDecoration(
                          labelText: 'EVENT COST',
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blueAccent))),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller: _eventLocationController,
                      decoration: const InputDecoration(
                          labelText: 'EVENT LOCATION',
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blueAccent))),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller: _eventImageUrlController,
                      decoration: const InputDecoration(
                          labelText: 'EVENT IMAGE URL',
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blueAccent))),
                    ),
                    const SizedBox(height: 45.0),
                    MaterialButton(
                      onPressed: () async {
                        await Database.createEvent(
                          Event(
                            eventID: const Uuid().v4(),
                            eventCost: int.parse(_eventCostController.text),
                            eventDate: _eventDateController.text,
                            eventImageUrl: _eventImageUrlController.text,
                            eventLocation: _eventLocationController.text,
                            eventName: _eventNameController.text,
                            eventTime: _eventTimeController.text,
                            totalCost: int.parse(_eventtotalCostController.text),
                          ),
                        );
                        _eventNameController.clear();
                        _eventDateController.clear();
                        _eventTimeController.clear();
                        _eventCostController.clear();
                        _eventLocationController.clear();
                        _eventImageUrlController.clear();
                        _eventtotalCostController.clear();
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Event created!'),
                          behavior: SnackBarBehavior.floating,
                        ));
                      },
                      color: Colors.blue,
                      elevation: 7.0,
                      child: const Center(
                        child: Text(
                          'CREATE EVENT',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              )
            ]),
      ),
    );
  }
}
