import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:naoty/app/modules/home/home_controller.dart';
class HomeView extends GetView<HomeController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        actions: [
          IconButton(icon: Icon(Icons.menu, color: Get.theme.primaryColor, size: 30,), onPressed: () {

          })
        ],
      ),
      body: Obx(()=> controller.notes.isEmpty ? Center(child: CircularProgressIndicator())
      : ListView.builder(
        itemCount: controller.notes.length,
        itemBuilder: (context, int index) {
          return ListTile(
            title: Text(controller.notes[index].content?? "", overflow: TextOverflow.ellipsis,),
            subtitle: Text(DateFormat.yMMMMd('fr_FR').format(DateTime.parse(controller.notes[index].createdAt))?? ""),
            onTap: () {
              controller.goToEditor(index);
            },
          );
        },
      )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          controller.create();
        },
      ),
    );
  }
}