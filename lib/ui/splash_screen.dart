import 'package:flutter/material.dart';
import 'dart:async';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash_screen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    splashScreen();
  }

  splashScreen() {
    var splashDuration = const Duration(seconds: 3);
    return Timer(splashDuration, () {
      Navigator.pushReplacementNamed(context, '/home_page');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
            width: 200,
            height: 200,
            child: Column(
              children: [
                LottieBuilder.asset('assets/splashrestaurant.json'),
              ],
            )),
      ),
    );
  }
}
