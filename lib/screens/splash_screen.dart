
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/screens/auth_screen.dart';
import 'package:shop_app/screens/home_page.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash-screen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
   
    super.initState();
     Future.delayed(Duration(seconds: 5), () {
      handleAuthStatus();
    });
  }

  void handleAuthStatus() async {
    
    if(FirebaseAuth.instance.currentUser!=null){
      AppAuthProvider().setLoginStatus(true);
      Navigator.of(context).pushNamedAndRemoveUntil(HomePage.routeName,(route)=>false);
    }else{
      AppAuthProvider().setLoginStatus(false);
      Navigator.of(context).pushNamedAndRemoveUntil(AuthScreen.routeName,(route)=>false);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
                color: Colors.black, size: 40),
          ),
          const Center(
            child: Text('Loading...'),
          ),
        ],
      ),
    );
  }
}
