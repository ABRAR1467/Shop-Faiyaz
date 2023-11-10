// ignore_for_file: unnecessary_null_comparison

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:shop_app/api/auth_api.dart';

class AppAuthProvider with ChangeNotifier {
  bool isloggedIn = false;


  void checkLoginStatus() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        isloggedIn = false;
      } else {
        print('User is signed in!');
        isloggedIn = true;
      }
    });
    notifyListeners();
  }

  void setLoginStatus(bool status) {
    isloggedIn = status;
    notifyListeners();
  }

  Future<User?> signUp(String email, String password) async {
    var user = await AuthApi.signUp(email, password);
    if(user!=null){
      user = await AuthApi.signIn(email, password);
      isloggedIn = true;
      notifyListeners();
    }else{
      print("error");
      //show snakbar
    }
  }

  Future<User?> login(String email, String password) async {
    return AuthApi.signIn(email, password);
  }

  void logout() async {
    AuthApi.signOut();
    notifyListeners();
  }


  ///singleton pattern
  static final AppAuthProvider _instance = AppAuthProvider._internal();
  AppAuthProvider._internal();
  factory AppAuthProvider() => _instance;
}
