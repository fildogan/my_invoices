import 'package:flutter/material.dart';
import 'package:my_invoices/app/core/config.dart';
import 'package:my_invoices/features/auth/auth_gate.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: Config.debugShowCheckedModeBanner,
      title: 'Invoice App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const AuthGate(),
    );
  }
}
