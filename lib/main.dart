import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import './controllers/auth_controller.dart';
import './screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(AuthController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Talabat',
      theme: ThemeData(
          primaryColor: Color(0xFFFF8001),
          accentColor: Colors.white,
          fontFamily: 'Sahitya'),
      home: WelcomeScreen(),
    );
  }
}
