import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naoty/app/modules/splash/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    controller;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: CircularProgressIndicator(),),
    );
  }
}