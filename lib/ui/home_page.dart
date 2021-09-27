import 'package:flutter/material.dart';
import 'package:submission_3/ui/detail_page.dart';
import 'package:submission_3/ui/favorite_page.dart';
import 'package:submission_3/ui/restaurant_list_page.dart';
import 'package:submission_3/ui/search_page.dart';
import 'package:submission_3/ui/settings_page.dart';
import 'package:submission_3/utils/background_service.dart';
import 'package:submission_3/utils/notification_helper.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int bottomNavIndex = 0;
    final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _backgroundService = BackgroundService();

  @override
  void initState() {
    super.initState();
    port.listen((_) async => await _backgroundService.someTask());
    _notificationHelper.configureSelectNotificationsSubject(
        DetailPage.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bottomNavIndex == 0
          // Page
          ? RestaurantList()
          : bottomNavIndex == 1
              ? SearchPage()
              : bottomNavIndex == 2
              ? FavoritePage()
              : SettingsPage(),

      // Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        currentIndex: bottomNavIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorite'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
        onTap: (index) {
          setState(() {
            bottomNavIndex = index;
          });
        },
      ),
    );
  }
}
