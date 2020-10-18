import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naoty/app/modules/about/about_controller.dart';

class AboutView extends GetView<AboutController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AboutPage')),
      body: Container(),
    );
  }
}