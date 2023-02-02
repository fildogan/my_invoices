import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:moje_faktury/features/auth/auth_gate.dart';
import 'package:moje_faktury/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // configureDependencies();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AuthGate(),
    );
  }
}
