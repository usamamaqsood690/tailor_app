import 'package:flutter/material.dart';
import 'package:tailor_app/view/screens/dashboard/orders.dart';
import 'package:tailor_app/view/screens/mesurment/measurements.dart';
import 'package:tailor_app/view/screens/splach/splach.dart';

class Routes {
  static const String splashRoute = "/";
  static const String orderRoute = "/order";
  static const String dashRoute = "/dashboard";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => Splach());
      case Routes.orderRoute:
        return MaterialPageRoute(builder: (_) => Orders());
      case Routes.dashRoute:
        return MaterialPageRoute(builder: (_) => Dashboard());

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(title: Text("No Route Found")),
              body: Center(child: Text("No Route Found")),
            ));
  }
}
