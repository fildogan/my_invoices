import 'package:flutter/material.dart';
import 'package:my_invoices/app/core/config.dart';
import 'package:my_invoices/features/auth/auth_gate.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: Config.debugShowCheckedModeBanner,
      title: 'Invoice App',
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.orange,
      ),
      darkTheme: ThemeData.dark(useMaterial3: false),
      themeMode: currentTheme.currentTheme,
      home: const AuthGate(),
    );
  }
}
