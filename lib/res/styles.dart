import 'package:flutter/material.dart';

final Color primaryColor = Color(0xffFFFFFF);
final Color secondaryColor = Color(0xFF6B38FB);
final Color darkPrimaryColor = Color(0xFF000000);
final Color darkSecondaryColor = Color(0xff64ffda);

ThemeData lighTheme = ThemeData(
    primaryColor: primaryColor,
    accentColor: secondaryColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: secondaryColor, unselectedItemColor: Colors.grey),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            primary: secondaryColor,
            textStyle: TextStyle(),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(0))))));

ThemeData darkTheme = ThemeData.dark().copyWith(
  primaryColor: darkPrimaryColor,
  accentColor: darkSecondaryColor,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: darkSecondaryColor, unselectedItemColor: Colors.grey),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            primary: secondaryColor,
            textStyle: TextStyle(),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(0)))))
);
