import 'dart:async';
import 'package:get/get.dart';
import 'package:handicraftmobilefrontend/features/auth/views/login_view.dart';
import 'package:flutter/material.dart';
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    //after 3 second it will move to login screen
    Timer(Duration(seconds: 3),(){
      Get.off(LoginView());
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(child: Image.asset("assets/images/Main Splash Canvas.png"))
        ],
      ),
    );
  }
}
