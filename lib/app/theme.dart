import 'package:flutter/material.dart';
import 'package:my_invoices/app/core/enums.dart';
import 'package:my_invoices/app/core/preferences_service.dart';

class MyTheme with ChangeNotifier {
  SelectedTheme _selectedTheme = SelectedTheme.system;

  SelectedTheme get selectedTheme => _selectedTheme;

  set selectedTheme(SelectedTheme value) {
    _selectedTheme = value;
    notifyListeners();
  }

  ThemeMode get currentTheme {
    switch (_selectedTheme) {
      case SelectedTheme.light:
        return ThemeMode.light;
      case SelectedTheme.dark:
        return ThemeMode.dark;
      case SelectedTheme.system:
        return ThemeMode.system;
    }
  }

  static final MyTheme _instance = MyTheme._internal();

  factory MyTheme() {
    return _instance;
  }

  MyTheme._internal();

  void switchTheme(int index) {
    switch (index) {
      case 0:
        selectedTheme = SelectedTheme.light;
        PreferencesService().saveTheme(SelectedTheme.light);
        notifyListeners();
        break;

      case 1:
        selectedTheme = SelectedTheme.dark;
        PreferencesService().saveTheme(SelectedTheme.dark);
        notifyListeners();
        break;
      case 2:
        selectedTheme = SelectedTheme.system;
        PreferencesService().saveTheme(SelectedTheme.system);
        notifyListeners();
        break;
    }
  }

  int get index {
    switch (currentTheme) {
      case ThemeMode.light:
        return 0;
      case ThemeMode.dark:
        return 1;
      case ThemeMode.system:
        return 2;
    }
  }
}
