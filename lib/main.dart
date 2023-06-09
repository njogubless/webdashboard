import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hikers_dash/firebase_options.dart';
import 'package:hikers_dash/sections/authenticate/wrapper.dart';
import 'package:hikers_dash/services/auth.dart';
import 'package:hikers_dash/services/auth_notifer.dart';
import 'package:hikers_dash/services/models/client.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthNotifier(),
      child: StreamProvider<Client?>.value(
        initialData: null,
        value: AuthService().auth,
        child: MaterialApp(
          title: 'HikersDash',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const Wrapper(),
        ),
      ),
    );
  }
}
