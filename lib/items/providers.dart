import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:submission_3/data/api/api_service.dart';
import 'package:submission_3/data/database/database_helper.dart';
import 'package:submission_3/data/preferences/preferences_helper.dart';
import 'package:submission_3/data/provider/database_provider.dart';
import 'package:submission_3/data/provider/preferences_provider.dart';
import 'package:submission_3/data/provider/restaurant_list_provider.dart';
import 'package:submission_3/data/provider/scheduling_provider.dart';
import 'package:submission_3/data/provider/search_restaurant_provider.dart';

final List<SingleChildWidget> providers = [
  ChangeNotifierProvider(
      create: (_) => RestaurantProvider(apiService: ApiService())),
  ChangeNotifierProvider(
      create: (_) => SearchRestaurantProvider(apiService: ApiService())),
  ChangeNotifierProvider(
      create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper())),
  ChangeNotifierProvider(
    create: (_) => SchedulingProvider()
  ),
  ChangeNotifierProvider(create: (_) => PreferencesProvider(
    preferencesHelper: PreferencesHelper(
      sharedPreferences: SharedPreferences.getInstance())
  ))
];
