import 'package:tailor_app/view/screens/dashboard/delivery.dart';
import 'package:tailor_app/view/screens/dashboard/home.dart';
import 'package:tailor_app/view/screens/dashboard/notification.dart';
import 'package:tailor_app/view/screens/dashboard/orders.dart';
import 'package:tailor_app/view/screens/mesurment/measurements.dart';
import 'package:tailor_app/view/screens/splach/splach.dart';
import 'package:flutter/material.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.in
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tailor App',
      theme: ThemeData(
          // Set your theme here
          ),
      home: Splach(),
      routes: {
        '/dashboard': (context) => Dashboard(),
        '/orders': (context) => Orders(),
        '/home': (context) => Home(),
        '/delivery': (context) => Delivery(),
        '/notification': (context) => Notif(),
      },
    );
  }
}
