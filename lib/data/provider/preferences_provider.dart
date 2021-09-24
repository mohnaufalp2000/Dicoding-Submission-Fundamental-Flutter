import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:submission_3/data/preferences/preferences_helper.dart';
import 'package:submission_3/res/styles.dart';

class PreferencesProvider extends ChangeNotifier {
  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;

  bool _isDailyRestaurantActive = false;
  bool get isDailyRestaurantActive => _isDailyRestaurantActive;

  PreferencesHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper}) {
    _getTheme();
    _getDailyRestaurantPreferences();
  }

  ThemeData get themeData => _isDarkTheme ? darkTheme : lighTheme;

  void _getTheme() async {
    _isDarkTheme = await preferencesHelper.isDarkTheme;
    notifyListeners();
  }

  void _getDailyRestaurantPreferences() async {
    _isDailyRestaurantActive = await preferencesHelper.isDailyRestaurantActive;
    notifyListeners();
  }

  void enabledDarkTheme(bool value) {
    preferencesHelper.setDarkTheme(value);
    _getTheme();
  }

  void enabledDailyNews(bool value) {
    preferencesHelper.setDailyRestaurant(value);
    _getDailyRestaurantPreferences();
  }
}
