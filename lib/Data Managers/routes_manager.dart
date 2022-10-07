import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/Data%20Managers/colors_manager.dart';
import 'package:portfolio/Data%20Managers/strings_manager.dart';
import 'package:portfolio/Views/Splash/splash_view.dart';

import '../Views/Home/home_view.dart';

class RoutesName {
  static const String splash = '/';
  static const String home = '/home';
}

class RoutesGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(builder: (_) => SplashView());
      case RoutesName.home:
        return MaterialPageRoute(builder: (_) => HomeView());
      default:
        return MaterialPageRoute(builder: (_) => _undefinedRoute());
    }
  }

  static Widget _undefinedRoute() => Scaffold(
        appBar: AppBar(),
        backgroundColor: ColorsManager.greyColor,
        body: const Center(child: Text(AppStrings.undefinedError)),
      );
}
