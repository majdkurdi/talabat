import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../services/authentication.dart';

class AuthController extends GetxController {
  late final Rx<UserCredential> currentUser;
  final auth = Auth();

  Future<String> login(String email, String password) async {
    try {
      currentUser = (await auth.signIn(email, password)).obs;
      return 'loggedin';
    } on FirebaseAuthException catch (e) {
      return e.code;
    } on Exception catch (_) {
      return 'Error';
    }
  }

  Future signUp(String email, String password) async {
    try {
      currentUser = (await auth.signUp(email, password)).obs;
      return 'loggedin';
    } on FirebaseAuthException catch (e) {
      return e.code;
    } on Exception catch (_) {
      return 'Error';
    }
  }
}
