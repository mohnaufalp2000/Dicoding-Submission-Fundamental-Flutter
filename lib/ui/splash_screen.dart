import 'dart:async';

import 'package:flutter/material.dart';
import 'package:submission_3/main.dart';
import 'package:submission_3/ui/detail_page.dart';
import 'package:submission_3/ui/home_page.dart';
import 'package:submission_3/utils/background_service.dart';
import 'package:submission_3/utils/notification_helper.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash_screen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final NotificationHelper _notificationHelper = NotificationHelper();

  @override
  void initState() {
    super.initState();
    _notificationHelper
        .configureSelectNotificationsSubject(DetailPage.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  splashScreen() {
    var duration = const Duration(seconds: 3);
    return Timer(duration, () {
      Navigator.pushReplacementNamed(context, HomePage.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    splashScreen();
    return Scaffold(body: Center(child: Text('Ini Restaurant')));
  }
}
