import 'package:flutter/cupertino.dart';
import 'package:submission_3/ui/detail_page.dart';
import 'package:submission_3/ui/home_page.dart';
import 'package:submission_3/ui/splash_screen.dart';

var routes = {
  SplashScreen.routeName : (context) => SplashScreen(),
  HomePage.routeName: (context) => HomePage(),
  DetailPage.routeName: (context) => DetailPage(
    id: ModalRoute.of(context)?.settings.arguments as String
  )
};
