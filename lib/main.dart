import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:submission_1/data/model/list_restaurant.dart';
import 'package:submission_1/ui/detail_page.dart';
import 'package:submission_1/ui/home_page/home_page.dart';
import 'package:submission_1/ui/categories_page/categories_page.dart';
import 'package:submission_1/ui/search_page/search_page.dart';
import 'package:submission_1/ui/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        HomePage.routeName: (context) => HomePage(),
        SearchPage.routeName: (context) => SearchPage(),
        CategoriesPage.routeName: (context) => CategoriesPage(ModalRoute.of(context)?.settings.arguments as String),
        DetailPage.routeName: (context) => DetailPage(ModalRoute.of(context)?.settings.arguments as String)
      },
    );
  }
}