import 'package:flutter/material.dart';
import 'package:ibtikartask/model/person_model.dart';

import '../../modules/details_screen/person_details_screen.dart';
import '../../modules/home/home_screen.dart';
import '../../modules/splash/splash_screen.dart';



class Routes {
  static const String splashScreen = '/splash_screen';
  static const String homeScreen = '/home';
  static const String personDetailsScreen = '/person_details_screen';

}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;


    switch (routeSettings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case Routes.personDetailsScreen:
        return MaterialPageRoute(builder: (_) =>  PersonDetailsScreen(personModel: args as PersonModel,));
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Route Not Found'),
        ),
        body: const Center(
          child: Text('This Rout Is Not Found'),
        ),
      ),
    );
  }
}
