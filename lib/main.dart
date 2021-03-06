import 'package:flutter/material.dart';
import 'package:submission_1/data/restaurant.dart';
import 'package:submission_1/ui/detail_page.dart';
import 'package:submission_1/ui/home_page.dart';
import 'package:submission_1/ui/restaurant_list.dart';
import 'package:submission_1/ui/search_page.dart';
import 'package:submission_1/ui/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        HomePage.routeName: (context) => HomePage(),
        SearchPage.routeName: (context) => SearchPage(),
        RestaurantList.routeName: (context) => RestaurantList(ModalRoute.of(context)?.settings.arguments as String),
        DetailPage.routeName: (context) => DetailPage(ModalRoute.of(context)?.settings.arguments as Restaurant)
      },
    );
  }
}