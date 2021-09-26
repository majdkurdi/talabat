import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<UserCredential> signIn(String email, String password) async {
    try {
      return await auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw e;
    } on Exception catch (e) {
      throw e;
    }
  }

  Future<UserCredential> signUp(String email, String password) async {
    try {
      return await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw e;
    } on Exception catch (e) {
      throw e;
    }
  }

  void refreshToken() {
    try {
      auth.currentUser!.refreshToken;
    } on Exception catch (e) {
      throw e;
    }
  }

  Future<void> changePassword(String newPassword) async {
    try {
      auth.currentUser!.updatePassword(newPassword);
    } on Exception catch (e) {
      throw e;
    }
  }

  Future<void> signOut() async {
    try {
      await auth.signOut();
    } on Exception catch (e) {
      throw e;
    }
  }

  bool get isLoggedIn {
    if (auth.currentUser == null)
      return false;
    else
      return true;
  }
}
