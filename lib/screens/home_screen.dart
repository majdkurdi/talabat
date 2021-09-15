import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talabat/screens/account_screen.dart';
import '../screens/orders_screen.dart';
import '../screens/restaurants_screen.dart';
import '../widgets/custom_animated_bottom_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  Widget getBody() {
    List<Widget> pages = [Restaurants(), OrdersScreen(), AccountScreen()];
    return IndexedStack(
      index: currentIndex,
      children: pages,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CustomAnimatedBottomBar(
          containerHeight: Get.size.height / 12,
          selectedIndex: currentIndex,
          items: [
            BottomNavyBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
              activeColor: Theme.of(context).primaryColor,
              inactiveColor: Colors.grey,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.list_alt),
              title: Text('orders'),
              activeColor: Theme.of(context).primaryColor,
              inactiveColor: Colors.grey,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.person_outline),
              title: Text('Account'),
              activeColor: Theme.of(context).primaryColor,
              inactiveColor: Colors.grey,
              textAlign: TextAlign.center,
            ),
          ],
          onItemSelected: (i) {
            setState(() => currentIndex = i);
          },
        ),
        body: getBody());
  }
}
