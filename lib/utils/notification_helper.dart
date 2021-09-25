import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:submission_3/data/model/restaurant_model.dart';
import 'package:submission_3/res/navigation.dart';
import 'package:submission_3/ui/detail_page.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;
  int random = 0;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        print('notification payload: ' + payload);
      }
      selectNotificationSubject.add(payload ?? 'empty payload');
    });
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      RestaurantResult restaurantResult) async {
    var _channelId = '1';
    var _channelName = "channel_01";
    var _channelDescription = "restaurant app channel";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        _channelId, _channelName, _channelDescription,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: DefaultStyleInformation(true, true));

    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    var titleNotification = "<b>Find Restaurant</b>";
    var restaurantLength = restaurantResult.restaurants.length;
    random = Random().nextInt(restaurantLength - 1);
    print(random);
    var titleRestaurant = restaurantResult.restaurants[0].name;

    await flutterLocalNotificationsPlugin.show(
        0, titleNotification, titleRestaurant, platformChannelSpecifics,
        payload: json.encode(restaurantResult.toJson()));
  }

  void configureSelectNotificationsSubject(BuildContext context, String route) {
    selectNotificationSubject.stream.listen((String payload) async {
      var data = RestaurantResult.fromJson(json.decode(payload));
      var restaurant = data.restaurants[0];
      await Navigator.pushNamed(context,route, arguments: restaurant.id);
    });
  }
}
