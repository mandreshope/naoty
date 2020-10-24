import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naoty/app/modules/connexion/reset_password/reset_password_controller.dart';
import 'package:naoty/app/widgets/input_field.dart';
import 'package:naoty/app/widgets/primary_button.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Get.theme.primaryColor,),
          onPressed: () {
            Get.back();
          }
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 15),
                margin: EdgeInsets.only(right: 60),
                alignment: Alignment.topLeft,
                child: Text("Réinitialisez \nvotre mot de passe".tr, style: TextStyle(
                  color: Get.theme.primaryColor, fontSize: 30
                ),),),
              InputField(
                controller: controller.codeController,
                prefixIcon: Icon(Icons.vpn_key, color: Get.theme.primaryColor,),
                keyboardType: TextInputType.emailAddress,
                hintText: "Code".tr,
                onChanged: (v) {
                  controller.isTextFieldEmpty();
                },
              ),
              InputField(
                controller: controller.passwordController,
                prefixIcon: Icon(Icons.security, color: Get.theme.primaryColor,),
                hintText: "Mot de passe".tr,
                onChanged: (v) {
                  controller.isTextFieldEmpty();
                },
              ),
              InputField(
                controller: controller.cpasswordController,
                prefixIcon: Icon(Icons.security, color: Get.theme.primaryColor,),
                hintText: "Confirmation mot de passe".tr,
                onChanged: (v) {
                  controller.isTextFieldEmpty();
                },
              ),
              SizedBox(height: 10,),
              Obx(()=>PrimaryButton(
                backgroundColor: controller.isButtonEnabled ? Get.theme.primaryColor : Colors.grey[200],
                child: Text("REINITIALISER".tr,style: TextStyle(
                color: controller.isButtonEnabled ? Colors.white : Get.theme.primaryColor.withOpacity(0.7),
                fontSize: 18,
              )), onPressed: () {
                controller.resetPassword();
              },),),
            ],
          ),
        ),
      ),
    );
  }
}