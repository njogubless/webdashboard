import 'package:flutter/material.dart';
import 'package:hikers_dash/sections/authenticate/sign_in.dart';
import 'package:hikers_dash/sections/home_page.dart';
import 'package:hikers_dash/services/models/client.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // Return either Home or Authentication widget

    final userAuth = Provider.of<Client?>(context);

    // Return either Home() or Authenticate()
    if (userAuth == null) {
      return SignIn();
    } else {
      return MyHomePage();
    }
  }
}
