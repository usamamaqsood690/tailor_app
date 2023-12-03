import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:tailor_app/constant.dart';
import 'package:tailor_app/view/screens/dashboard/delivery.dart';
import 'package:tailor_app/view/screens/dashboard/home.dart';
import 'package:tailor_app/view/screens/dashboard/notification.dart';
import 'package:tailor_app/view/screens/dashboard/orders.dart';
import 'package:tailor_app/view/screens/mesurment/measurements.dart';

class BottomNavBar extends StatefulWidget {
  // static const routeName = '/bottomNavBar';
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: appcolor,
        centerTitle: true,
        title: Text("Measurements"),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: appcolor,
        buttonBackgroundColor: appcolor,
        backgroundColor: Colors.transparent,
        items: [
          CurvedNavigationBarItem(
            labelStyle: TextStyle(color: dfColor),
            child: Icon(
              Icons.home_outlined,
              color: dfColor,
            ),
            label: 'Measurements',
          ),
          CurvedNavigationBarItem(
            labelStyle: TextStyle(color: dfColor),
            child: Icon(
              Icons.search,
              color: dfColor,
            ),
            label: 'Orders',
          ),
          CurvedNavigationBarItem(
            labelStyle: TextStyle(color: dfColor),
            child: Icon(
              Icons.chat_bubble_outline,
              color: dfColor,
            ),
            label: 'Home',
          ),
          CurvedNavigationBarItem(
            labelStyle: TextStyle(color: dfColor),
            child: Icon(
              Icons.newspaper,
              color: dfColor,
            ),
            label: 'Delivery Calendar',
          ),
          CurvedNavigationBarItem(
            labelStyle: TextStyle(color: dfColor),
            child: Icon(
              Icons.perm_identity,
              color: dfColor,
            ),
            label: 'Notification',
          ),
        ],
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      body: _getBodyWidget(),
    );
  }

  Widget _getBodyWidget() {
    switch (currentIndex) {
      case 0:
        return Dashboard();
      case 1:
        return Orders();
      case 2:
        return Home();
      case 3:
        return Delivery();
      case 4:
        return Notif();
      default:
        return DefaultWidget(); // Fallback to a default widget
    }
  }
}

class DefaultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // Your main content goes here
      child: Center(
        child: Text(
          'No Data Found!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
