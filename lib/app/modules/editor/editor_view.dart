import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'editor_controller.dart';

class EditorView extends GetView<EditorController> {

  @override
  Widget build(BuildContext context) {

    final editor = TextField( 
      maxLines: 10,
      minLines: 10,
      controller: controller.contentController,
      decoration: InputDecoration(
        border: InputBorder.none
      ),
      onChanged: (v) {
        controller.checkFieldIsEmpty();
      },
    );

    final form = Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            editor
          ],
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close, color: Get.context.theme.primaryColor, size: 30,), 
          onPressed: () {
            Get.back();
          }
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Contenu"),
        actions: <Widget>[
          Obx(()=>IconButton(
            icon: Icon(Icons.check, color: controller.isBtnSaveEnabled ? Get.context.theme.primaryColor : Get.context.theme.primaryColor.withOpacity(0.5), size: 30,),
            onPressed: () => controller.save(),
          ),)
        ],
      ),
      body: form,
    );
  }
}