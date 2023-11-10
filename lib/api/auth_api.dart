import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_app/api/user_api.dart';

class AuthApi {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<User?> signUp(String email, String password) async {
    try {
      final User? user = (await _auth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;

      if (user != null) {
        await UserApi.addUser(user.uid, email, email);
        return user;
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<User?> signIn(String email, String password) async {
    try {
      final User? user = (await _auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;

      if (user != null) {
        return user;
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> signOut() async {
    await _auth.signOut();
  }
}
