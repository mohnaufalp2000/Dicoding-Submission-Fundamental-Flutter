import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:submission_3/data/api/api_service.dart';
import 'package:submission_3/data/database/database_helper.dart';
import 'package:submission_3/data/provider/database_provider.dart';
import 'package:submission_3/data/provider/scheduling_provider.dart';
import 'package:submission_3/data/provider/search_restaurant_provider.dart';
import 'package:submission_3/ui/settings_page.dart';

final List<SingleChildWidget> providers = [
  ChangeNotifierProvider(
      create: (_) => SearchRestaurantProvider(apiService: ApiService())),
  ChangeNotifierProvider(
      create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper())),
  ChangeNotifierProvider(
    create: (_) => SchedulingProvider()
  )
];
