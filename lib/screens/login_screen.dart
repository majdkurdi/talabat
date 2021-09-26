import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../screens/home_screen.dart';
import '../widgets/my_text_field.dart';

enum SignType { In, Up }

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final authController = Get.find<AuthController>();
  SignType signType = SignType.In;
  String? email;
  String? password;
  String? mobile;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Form(
          key: _formKey,
          child: Container(
            height: Get.size.height,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40, bottom: 20),
                    child: Container(
                      child: Image(image: AssetImage('assets/logo.jpg')),
                      height: Get.size.height / 3,
                      width: Get.size.width,
                    ),
                  ),
                  MyTextField(
                    Icons.email,
                    TextInputType.emailAddress,
                    'Enter Your Email',
                    (String? val) {
                      if (val == null ||
                          !val.contains('@') ||
                          !val.contains('.'))
                        return 'Please Enter a Valid Email!';
                      else
                        return null;
                    },
                    (String? val) {
                      email = val;
                    },
                  ),
                  if (signType == SignType.Up)
                    MyTextField(
                      Icons.mobile_friendly,
                      TextInputType.number,
                      'Enter Your Mobile Number',
                      (String? val) {
                        if (val == null ||
                            int.tryParse(val) == null ||
                            val.length < 8)
                          return 'Please Enter a Valid Number!';
                        else
                          return null;
                      },
                      (String? val) {
                        mobile = val;
                      },
                    ),
                  MyTextField(Icons.lock, TextInputType.visiblePassword,
                      'Enter Your Password', (String? val) {
                    if (val == null || val.length < 6)
                      return 'Password is Short!';
                    else
                      return null;
                  }, (String? val) {
                    password = val;
                  }, true),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: Get.size.width / 2,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 15,
                            primary: Theme.of(context).accentColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              setState(() => loading = true);
                              if (signType == SignType.In) {
                                final value = await authController.login(
                                    email!, password!);
                                setState(() => loading = false);
                                if (value == 'loggedin') {
                                  Get.off(() => HomeScreen());
                                } else {
                                  Get.snackbar('Error!', value);
                                }
                              } else {
                                final value = await authController.signUp(
                                    email!, password!, mobile!);
                                setState(() => loading = false);
                                if (value == 'loggedin') {
                                  Get.off(() => HomeScreen());
                                } else {
                                  Get.snackbar('Error!', value);
                                }
                              }
                            }
                          },
                          child: loading
                              ? CircularProgressIndicator()
                              : Text(
                                  signType == SignType.In ? 'LogIn' : 'SignUp',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            signType = signType == SignType.In
                                ? SignType.Up
                                : SignType.In;
                          });
                        },
                        child: Text(
                          signType == SignType.In
                              ? 'Or Create New Account.'
                              : 'Already have an account? Login.',
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
