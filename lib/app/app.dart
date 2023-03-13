import 'package:flutter/material.dart';
import 'package:my_invoices/app/core/config.dart';
import 'package:my_invoices/app/core/preferences_service.dart';
import 'package:my_invoices/features/auth/auth_gate.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    PreferencesService().getTheme().then((selectedTheme) {
      currentTheme.selectedTheme = selectedTheme;
    });
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
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          useMaterial3: false,
          primarySwatch: Colors.orange,
          primaryColor: Colors.orange,
          appBarTheme: const AppBarTheme(
            foregroundColor: Colors.black,
            // systemOverlayStyle: SystemUiOverlayStyle.dark,
            backgroundColor: Colors.orange,
          )
          // .copyWith(backgroundColor: Colors.orange),
          ),
      themeMode: currentTheme.currentTheme,
      home: const AuthGate(),
    );
  }
}
