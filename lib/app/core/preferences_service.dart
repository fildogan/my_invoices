import 'package:my_invoices/app/core/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  Future saveTheme(SelectedTheme selectedTheme) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setInt('theme', selectedTheme.index);
  }

  Future getTheme() async {
    final preferences = await SharedPreferences.getInstance();
    final selectedTheme =
        SelectedTheme.values[preferences.getInt('theme') ?? 2];

    return selectedTheme;
  }
}
