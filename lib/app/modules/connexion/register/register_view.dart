import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:naoty/app/modules/connexion/register/register_controller.dart';
import 'package:naoty/app/widgets/input_field.dart';
import 'package:naoty/app/widgets/primary_button.dart';

import '../login/login_view.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key key}) : super(key: key);

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
              InputField(
                controller: controller.username,
                prefixIcon: Icon(Icons.person, color: Get.theme.primaryColor,),
                hintText: "Nom d'utilisateur".tr,
                onChanged: (v) {
                  controller.isTextFieldEmpty();
                },
              ),
              Obx(()=>InputField(
                controller: controller.email,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icon(Icons.email, color: Get.theme.primaryColor,),
                hintText: "Email".tr,
                errorText: controller.errorMessage == '' ? null : controller.errorMessage,
                borderColor: controller.errorMessage == '' ?  Colors.grey[200] : Get.theme.primaryColor,
                onChanged: (v) {
                  if(!v.isEmail){
                    controller.errorMessage = 'email invalide';
                  }else{
                    controller.errorMessage = '';
                  }
                  controller.isTextFieldEmpty();
                },
              ),),
              Obx(()=>InputField(
                controller: controller.password,
                prefixIcon: Icon(Icons.security, color: Get.theme.primaryColor,),
                obscureText: controller.obscureText,
                errorText: controller.passworedErrorMessage == '' ? null : controller.passworedErrorMessage,
                borderColor: controller.passworedErrorMessage == '' ?  Colors.grey[200] : Get.theme.primaryColor,
                hintText: "Mot de passe".tr,
                suffixIcon: IconButton(icon: Icon(controller.obscureText ? Icons.visibility_off : Icons.visibility, color: Get.theme.primaryColor.withOpacity(0.5),), 
                  onPressed: () {
                    controller.obscureText = !controller.obscureText;
                  }),
                onChanged: (v) {
                  if(v.length < 8) {
                    controller.passworedErrorMessage = 'Le champ Mot de passe doit comporter au moins 8 caractères.';
                  }else{
                    controller.passworedErrorMessage = '';
                  }
                  controller.isTextFieldEmpty();
                },
              ),),
              SizedBox(height: 20,),
              Obx(()=>PrimaryButton(
                backgroundColor: controller.isButtonEnabled ? Get.theme.primaryColor : Colors.grey[200],
                child: Text("S'INSCRIRE".tr,style: TextStyle(
                color: controller.isButtonEnabled ? Colors.white : Get.theme.primaryColor.withOpacity(0.7),
                fontSize: 18,
              )), onPressed: () {
                controller.register();
              },),),
              SizedBox(height: Get.height/10),
              Text("Si vous avez déjà un compte, cliquez ici.".tr, style: TextStyle(
                color: Get.theme.primaryColor,
                fontSize: 15
              ),),
              SizedBox(height: 10,),
              PrimaryButton(
                backgroundColor: Colors.white,
                borderColor: Colors.grey[200],
                child: Text("SE CONNECTER".tr,style: TextStyle(
                color: Get.theme.primaryColor,
                fontSize: 18,
              )), onPressed: () {
                Get.to(LoginView());
              },),
            ],
          ),
        ),
      ),
    );
  }
}