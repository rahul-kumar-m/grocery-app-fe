import 'dart:async';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app_fe/route.dart';
import 'package:grocery_app_fe/splash_screen.dart';

@RoutePage(name:"InitialPage")
class SplashScreenRoute extends StatefulWidget {
  @override
  _SplashScreenRouteState createState() => _SplashScreenRouteState();
}

class _SplashScreenRouteState extends State<SplashScreenRoute> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(milliseconds: 2000), // Adjust the duration as needed
          () {
        // Navigate to the main screen or home page
            //context.router.popTop();
       context.router.push(LoginPageRoute());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(); // Display the splash screen widget
  }
}