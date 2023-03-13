import 'package:flutter/material.dart';

class ManageEvents extends StatelessWidget {
  const ManageEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SingleChildScrollView(
        child: Column(
          children: const [
            Text('Manage Events'),
          ],
        ),
      ),
    );
  }
}
