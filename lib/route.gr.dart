// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'route.dart';

abstract class _$MyRouter extends RootStackRouter {
  // ignore: unused_element
  _$MyRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    CartPageRoute.name: (routeData) {
      final args = routeData.argsAs<CartPageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: Cart(
          key: args.key,
          user: args.user,
        ),
      );
    },
    HomePageroute.name: (routeData) {
      final args = routeData.argsAs<HomePagerouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: Homepage(
          key: args.key,
          user: args.user,
        ),
      );
    },
    LoginPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LoginPage(),
      );
    },
    MenuRoutePage.name: (routeData) {
      final args = routeData.argsAs<MenuRoutePageArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: MenuPage(
          key: args.key,
          user: args.user,
        ),
      );
    },
    SignupPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SignUpPage(),
      );
    },
    InitialPage.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SplashScreenRoute(),
      );
    },
    Thankyoupage.name: (routeData) {
      final args = routeData.argsAs<ThankyoupageArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ThankYou(
          key: args.key,
          user: args.user,
        ),
      );
    },
  };
}

/// generated route for
/// [Cart]
class CartPageRoute extends PageRouteInfo<CartPageRouteArgs> {
  CartPageRoute({
    Key? key,
    required User user,
    List<PageRouteInfo>? children,
  }) : super(
          CartPageRoute.name,
          args: CartPageRouteArgs(
            key: key,
            user: user,
          ),
          initialChildren: children,
        );

  static const String name = 'CartPageRoute';

  static const PageInfo<CartPageRouteArgs> page =
      PageInfo<CartPageRouteArgs>(name);
}

class CartPageRouteArgs {
  const CartPageRouteArgs({
    this.key,
    required this.user,
  });

  final Key? key;

  final User user;

  @override
  String toString() {
    return 'CartPageRouteArgs{key: $key, user: $user}';
  }
}

/// generated route for
/// [Homepage]
class HomePageroute extends PageRouteInfo<HomePagerouteArgs> {
  HomePageroute({
    Key? key,
    required User user,
    List<PageRouteInfo>? children,
  }) : super(
          HomePageroute.name,
          args: HomePagerouteArgs(
            key: key,
            user: user,
          ),
          initialChildren: children,
        );

  static const String name = 'HomePageroute';

  static const PageInfo<HomePagerouteArgs> page =
      PageInfo<HomePagerouteArgs>(name);
}

class HomePagerouteArgs {
  const HomePagerouteArgs({
    this.key,
    required this.user,
  });

  final Key? key;

  final User user;

  @override
  String toString() {
    return 'HomePagerouteArgs{key: $key, user: $user}';
  }
}

/// generated route for
/// [LoginPage]
class LoginPageRoute extends PageRouteInfo<void> {
  const LoginPageRoute({List<PageRouteInfo>? children})
      : super(
          LoginPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MenuPage]
class MenuRoutePage extends PageRouteInfo<MenuRoutePageArgs> {
  MenuRoutePage({
    Key? key,
    required User user,
    List<PageRouteInfo>? children,
  }) : super(
          MenuRoutePage.name,
          args: MenuRoutePageArgs(
            key: key,
            user: user,
          ),
          initialChildren: children,
        );

  static const String name = 'MenuRoutePage';

  static const PageInfo<MenuRoutePageArgs> page =
      PageInfo<MenuRoutePageArgs>(name);
}

class MenuRoutePageArgs {
  const MenuRoutePageArgs({
    this.key,
    required this.user,
  });

  final Key? key;

  final User user;

  @override
  String toString() {
    return 'MenuRoutePageArgs{key: $key, user: $user}';
  }
}

/// generated route for
/// [SignUpPage]
class SignupPageRoute extends PageRouteInfo<void> {
  const SignupPageRoute({List<PageRouteInfo>? children})
      : super(
          SignupPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignupPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SplashScreenRoute]
class InitialPage extends PageRouteInfo<void> {
  const InitialPage({List<PageRouteInfo>? children})
      : super(
          InitialPage.name,
          initialChildren: children,
        );

  static const String name = 'InitialPage';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ThankYou]
class Thankyoupage extends PageRouteInfo<ThankyoupageArgs> {
  Thankyoupage({
    Key? key,
    required User user,
    List<PageRouteInfo>? children,
  }) : super(
          Thankyoupage.name,
          args: ThankyoupageArgs(
            key: key,
            user: user,
          ),
          initialChildren: children,
        );

  static const String name = 'Thankyoupage';

  static const PageInfo<ThankyoupageArgs> page =
      PageInfo<ThankyoupageArgs>(name);
}

class ThankyoupageArgs {
  const ThankyoupageArgs({
    this.key,
    required this.user,
  });

  final Key? key;

  final User user;

  @override
  String toString() {
    return 'ThankyoupageArgs{key: $key, user: $user}';
  }
}
