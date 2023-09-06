import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:grocery_app_fe/login/ui/Login.dart';
import 'package:grocery_app_fe/route.dart';

import 'home/ui/home.dart';
import 'package:auto_route/auto_route.dart';




void main() {

  runApp(App());
}

class App extends StatelessWidget {
  // make sure you don't initiate your router
  // inside of the build function.
  final _appRouter = MyRouter();
  @override
  Widget build(BuildContext context){
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
      theme: ThemeData(
        primarySwatch: Colors.teal,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true
      ),
    );
  }
}