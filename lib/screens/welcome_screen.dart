import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './intro_screen.dart';
import './login_screen.dart';
import './home_screen.dart';
import '../controllers/auth_controller.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final authController = Get.find<AuthController>();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 0)).then((_) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final firstTime = prefs.getBool('first time');
      await Future.delayed(Duration(seconds: 2));
      if (firstTime == null || firstTime) {
        prefs.setBool('first time', false);
        Get.off(() => IntroScreen());
      } else {
        if (!authController.isLoggedIn)
          Get.off(() => LoginScreen());
        else {
          authController.profile.value = {
            'email': prefs.getString('email'),
            'mobile': prefs.getString('mobile'),
            'name': prefs.getString('name'),
            'address': prefs.getString('address')
          };
          Get.off(() => HomeScreen());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(60),
          height: Get.size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Image(
                    image: AssetImage('assets/logo.jpg'),
                  ),
                  Text(
                    'Talabat',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 60,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
