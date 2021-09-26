import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/authentication.dart';
import '../services/firestore.dart';

class AuthController extends GetxController {
  final profile = <String, String?>{}.obs;
  final auth = Auth();
  final firestore = Firestore();

  Future<String> login(String email, String password) async {
    try {
      await auth.signIn(email, password);
      profile.value = (await firestore.getUser(email));
      final prefs = await SharedPreferences.getInstance();
      for (int i = 0; i < profile.length; i++) {
        prefs.setString(
            profile.keys.toList()[i], profile.values.toList()[i] ?? '');
      }
      return 'loggedin';
    } on FirebaseAuthException catch (e) {
      return e.code;
    } on Exception catch (_) {
      return 'Error';
    }
  }

  Future signUp(String email, String password, String mobile) async {
    try {
      await auth.signUp(email, password);
      await firestore.addUser(email, mobile);
      await firestore.addOrderList(email);
      profile.value = await firestore.getUser(email);
      final prefs = await SharedPreferences.getInstance();
      for (int i = 0; i < profile.length; i++) {
        prefs.setString(
            profile.keys.toList()[i], profile.values.toList()[i] ?? '');
      }
      return 'loggedin';
    } on FirebaseAuthException catch (e) {
      return e.code;
    } on Exception catch (_) {
      return 'Error';
    }
  }

  Future updateProfile({String? mobile, String? name, String? address}) async {
    final newProfile = {
      'email': profile['email'],
      'mobile': mobile ?? profile['mobile'],
      'address': address ?? profile['address'],
      'name': name ?? profile['name']
    };

    try {
      print(2);
      await firestore.updateUser(newProfile);
      profile.value = newProfile;
      print(3);
      final prefs = await SharedPreferences.getInstance();
      for (int i = 0; i < profile.length; i++) {
        prefs.setString(
            profile.keys.toList()[i], profile.values.toList()[i] ?? '');
      }
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  Future changePassword(String newPassword) async {
    try {
      print(1);
      auth.refreshToken();
      print(2);
      await auth.changePassword(newPassword);
      print(3);
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  Future<bool> signout() async {
    try {
      await auth.signOut();
      final prefs = await SharedPreferences.getInstance();
      for (int i = 0; i < profile.length; i++) {
        prefs.remove(profile.keys.toList()[i]);
      }
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  bool get isLoggedIn {
    return auth.isLoggedIn;
  }
}
