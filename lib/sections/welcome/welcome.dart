import 'package:flutter/material.dart';

class WelcomeSection extends StatefulWidget {
  const WelcomeSection({
    super.key,
    required this.switchPage,
  });

  final Function(int index) switchPage;

  @override
  State<WelcomeSection> createState() => _WelcomeSectionState();
}

class _WelcomeSectionState extends State<WelcomeSection> {
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
                'Welcome to HikersAfrique',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                ),
              ),
              SizedBox(height: 50),
              const Text(
                'House keeping',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 20),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Verified users: 10'),
                  Text('Users awaiting verification: 3'),
                ],
              ),
              SizedBox(height: 20),
              MaterialButton(
                onPressed: () => widget.switchPage(1),
                color: Colors.blue,
                elevation: 3.0,
                child: const Center(
                  child: Text(
                    'Verify users',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'),
                  ),
                ),
              ),
              SizedBox(height: 20),
              MaterialButton(
                onPressed: () => widget.switchPage(2),
                color: Colors.blue,
                elevation: 3.0,
                child: const Center(
                  child: Text(
                    'Add events',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'),
                  ),
                ),
              ),
              SizedBox(height: 20),
              MaterialButton(
                onPressed: () => widget.switchPage(3),
                color: Colors.blue,
                elevation: 3.0,
                child: const Center(
                  child: Text(
                    'Manage events',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'),
                  ),
                ),
              ),
              SizedBox(height: 20),
              MaterialButton(
                onPressed: () => widget.switchPage(4),
                color: Colors.blue,
                elevation: 3.0,
                child: const Center(
                  child: Text(
                    'See booked events',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
