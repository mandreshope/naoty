import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:naoty/app/modules/home/home_controller.dart';

class HomeView extends GetView<HomeController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(()=> controller.notes.isEmpty ? Center(child: CircularProgressIndicator())
      : ListView.builder(
        itemCount: controller.notes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(controller.notes[index].title ?? ""),
            subtitle: Text(DateFormat.yMMMMd('fr_FR').format(DateTime.parse(controller.notes[index].createdAt))?? ""),
          );
        },
      ))
    );
  }
}