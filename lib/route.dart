import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app_fe/data/user.dart';
import 'package:grocery_app_fe/signup/ui/signup.dart';
import 'package:grocery_app_fe/splash_screen.dart';
import 'package:grocery_app_fe/splash_screen_initital.dart';
import 'package:grocery_app_fe/thankyou/ui/thankyou.dart';

import 'cart/ui/cart.dart';
import 'login/ui/Login.dart';
import 'home/ui/home.dart';
import 'menu/ui/menu.dart';
part 'route.gr.dart';
@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class MyRouter extends _$MyRouter {

  @override
  List<AutoRoute> get routes => [
    //HomeScreen is generated as HomeRoute because
    //of the replaceInRoutoeName property
    AutoRoute(page: InitialPage.page,initial: true) ,
    AutoRoute(page:LoginPageRoute.page),
     AutoRoute(page: HomePageroute.page,),
    AutoRoute(page: CartPageRoute.page),
    AutoRoute(page: MenuRoutePage.page),
    AutoRoute(page: SignupPageRoute.page),
    AutoRoute(page: Thankyoupage.page),


  ];
}
