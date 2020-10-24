import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'editor_controller.dart';

class EditorView extends GetView<EditorController> {

  @override
  Widget build(BuildContext context) {

    final editor = TextField( 
      maxLines: Get.height.toInt(),
      minLines: 1,
      controller: controller.contentController,
      autofocus: true,
      style: TextStyle(fontSize: 20),
      decoration: InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.all(0)
      ),
      onChanged: (v) {
        controller.checkFieldIsEmpty();
      },
    );

    final form = Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            editor,
            SizedBox(height: 10,),
            controller.note != null 
            ? Text("Dernière mise à jour le "+(DateFormat.yMMMMd('fr_FR').format(DateTime.parse(controller.note.updatedAt))?? "") +", "+ (DateFormat.Hm('fr_FR').format(DateTime.parse(controller.note.updatedAt))?? ""), )
            : Container(),
          ],
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close, color: Get.context.theme.primaryColor, size: 25,), 
          onPressed: () {
            Get.back();
          }
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: controller.note != null 
        ? Text((DateFormat.yMMMMd('fr_FR').format(DateTime.parse(controller.note.createdAt))?? "") +", "+ (DateFormat.Hm('fr_FR').format(DateTime.parse(controller.note.createdAt))?? ""), 
          style: TextStyle(
            color: Get.theme.primaryColor.withOpacity(0.5)
          ),
        )
        : Text((DateFormat.yMMMMd('fr_FR').format(DateTime.now())?? "") +", "+ (DateFormat.Hm('fr_FR').format(DateTime.now())?? ""), 
          style: TextStyle(
            color: Get.theme.primaryColor.withOpacity(0.5)
          ),
        ),
        actions: <Widget>[
          Obx(()=>IconButton(
            icon: Icon(Icons.check, color: controller.isBtnSaveEnabled 
            ? Get.context.theme.primaryColor 
            : Get.context.theme.primaryColor.withOpacity(0.5), size: 25,),
            onPressed: () => controller.save(),
          ),)
        ],
      ),
      body: form,
    );
  }
}