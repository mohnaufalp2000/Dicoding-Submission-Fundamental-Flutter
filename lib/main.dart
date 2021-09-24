import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:submission_3/data/provider/preferences_provider.dart';
import 'package:submission_3/items/providers.dart';
import 'package:submission_3/items/routes.dart';
import 'package:submission_3/res/navigation.dart';
import 'package:submission_3/ui/home_page.dart';
import 'package:submission_3/ui/splash_screen.dart';
import 'package:submission_3/utils/background_service.dart';
import 'package:submission_3/utils/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: Consumer<PreferencesProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: navigatorKey,
            title: 'Restaurant App',
            theme: provider.themeData,
            initialRoute: SplashScreen.routeName,
            routes: routes,
          );
        },
      ),
    );
  }
}
