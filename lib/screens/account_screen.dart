import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './login_screen.dart';
import '../controllers/auth_controller.dart';
import '../widgets/info_card.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final authController = Get.find<AuthController>();
  final formKey = GlobalKey<FormState>();

  final mobileFieldController = TextEditingController();
  final addressFieldController = TextEditingController();
  final nameFieldController = TextEditingController();
  String? password;

  bool loading = false;
  bool signingOut = false;

  @override
  void dispose() async {
    mobileFieldController.dispose();
    addressFieldController.dispose();
    nameFieldController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, String?> profile = authController.profile;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: null,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(10)),
            child: Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
        ),
        title: Text('Profile',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: Get.size.height * 1 / 8),
            Stack(clipBehavior: Clip.none, children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    )),
                constraints: BoxConstraints(
                  minHeight: Get.size.height * 2.75 / 4,
                ),
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(height: 100),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          profile['name'] ?? 'Your Name',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        loading
                            ? CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(Colors.grey),
                              )
                            : IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  Get.defaultDialog(
                                      title: 'Change your Name:',
                                      content: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: TextField(
                                          decoration: InputDecoration(
                                              hintText: 'New Name'),
                                          controller: nameFieldController,
                                        ),
                                      ),
                                      confirmTextColor:
                                          Theme.of(context).primaryColor,
                                      cancelTextColor: Colors.grey,
                                      textConfirm: 'Confirm',
                                      textCancel: 'Cancel',
                                      onConfirm: () async {
                                        Get.back();
                                        setState(() => loading = true);
                                        if (await authController.updateProfile(
                                            name: nameFieldController.text)) {
                                          setState(() => loading = false);
                                        }
                                      });
                                },
                              ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Divider(
                      indent: 50,
                      endIndent: 50,
                      thickness: 1,
                    ),
                    InfoCard(title: 'Account Information', children: [
                      ListTile(
                        leading: Text('Email:'),
                        title: Text(profile['email']!),
                      ),
                      ListTile(
                        leading: Text('Mobile:'),
                        title: Text(profile['mobile'] ?? 'No mobile provided'),
                        trailing: loading
                            ? CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(Colors.grey),
                              )
                            : IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  Get.defaultDialog(
                                      title: 'Change your mobile number:',
                                      content: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: TextField(
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              hintText: 'New mobile number'),
                                          controller: mobileFieldController,
                                        ),
                                      ),
                                      confirmTextColor:
                                          Theme.of(context).primaryColor,
                                      cancelTextColor: Colors.grey,
                                      textConfirm: 'Confirm',
                                      textCancel: 'Cancel',
                                      onConfirm: () async {
                                        Get.back();

                                        if (await authController.updateProfile(
                                            mobile:
                                                mobileFieldController.text)) {
                                          setState(() {});
                                        }
                                      });
                                },
                              ),
                      ),
                      ListTile(
                        leading: Text('Address:'),
                        title:
                            Text(profile['address'] ?? 'Enter Your address!'),
                        trailing: loading
                            ? CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(Colors.grey),
                              )
                            : IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  Get.defaultDialog(
                                      title: 'Change your Address:',
                                      content: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: TextField(
                                          decoration: InputDecoration(
                                              hintText: 'New Address'),
                                          controller: addressFieldController,
                                        ),
                                      ),
                                      confirmTextColor:
                                          Theme.of(context).primaryColor,
                                      cancelTextColor: Colors.grey,
                                      textConfirm: 'Confirm',
                                      textCancel: 'Cancel',
                                      onConfirm: () async {
                                        print(1);
                                        Get.back();

                                        if (await authController.updateProfile(
                                            address:
                                                addressFieldController.text)) {
                                          setState(() {});
                                        }
                                      });
                                },
                              ),
                      ),
                    ]),
                    InfoCard(title: 'Change Your Password', children: [
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: 'New Password',
                                ),
                                validator: (val) {
                                  if (val != null && val.length >= 6)
                                    return null;
                                  else
                                    return 'Try again';
                                },
                                onSaved: (val) {
                                  password = val;
                                },
                                onChanged: (val) {
                                  password = val;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: 'Confirm New Password',
                                ),
                                validator: (val) {
                                  if (val != null && val == password)
                                    return null;
                                  else
                                    return 'passwords are not the same!';
                                },
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  Get.defaultDialog(
                                    content: FutureBuilder(
                                      future: authController
                                          .changePassword(password!),
                                      builder: (BuildContext context,
                                          AsyncSnapshot snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return CircularProgressIndicator(
                                            valueColor: AlwaysStoppedAnimation(
                                                Colors.black),
                                          );
                                        } else {
                                          return Text(snapshot.data
                                              ? 'Password Changed Successfuly!'
                                              : 'Something went wrong!');
                                        }
                                      },
                                    ),
                                  );
                                }
                              },
                              child: Text(
                                'Change Password',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                    InfoCard(title: 'Sign Out', children: [
                      TextButton(
                        onPressed: () async {
                          setState(() => signingOut = true);
                          final signedout = await authController.signout();
                          if (signedout)
                            Get.offAll(() => LoginScreen());
                          else
                            setState(() => signingOut = false);
                        },
                        child: Text(
                          'Sign out',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      )
                    ]),
                  ],
                ),
              ),
              Positioned(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 75,
                  child: ClipRRect(
                    child: Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(75),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(75),
                        child: Image(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/profile.png'),
                        ),
                      ),
                    ),
                  ),
                ),
                top: -60,
                left: 5,
                right: 5,
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
