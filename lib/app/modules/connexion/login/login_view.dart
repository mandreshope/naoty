import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naoty/app/routes/app_pages.dart';
import 'package:naoty/app/widgets/input_field.dart';
import 'package:naoty/app/widgets/primary_button.dart';

import 'login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 15),
                alignment: Alignment.topLeft,
                child: Text(
                  "Avez-vous déjà\nun compte ?".tr,
                  style: TextStyle(color: Get.theme.primaryColor, fontSize: 30),
                ),
              ),
              InputField(
                controller: controller.identifierController,
                prefixIcon: Icon(
                  Icons.person,
                  color: Get.theme.primaryColor,
                ),
                hintText: "Nom d'utilisateur".tr,
                onChanged: (v) {
                  controller.isTextFieldEmpty();
                },
              ),
              Obx(
                () => InputField(
                  controller: controller.passwordController,
                  prefixIcon: Icon(
                    Icons.security,
                    color: Get.theme.primaryColor,
                  ),
                  obscureText: controller.obscureText,
                  hintText: "Mot de passe".tr,
                  suffixIcon: IconButton(
                      icon: Icon(
                        controller.obscureText
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Get.theme.primaryColor.withOpacity(0.5),
                      ),
                      onPressed: () {
                        controller.obscureText = !controller.obscureText;
                      }),
                  onChanged: (v) {
                    controller.isTextFieldEmpty();
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Obx(
                () => PrimaryButton(
                  width: double.infinity,
                  backgroundColor: controller.isButtonEnabled
                      ? Get.theme.primaryColor
                      : Colors.grey[200],
                  child: Text("SE CONNECTER".tr,
                      style: TextStyle(
                        color: controller.isButtonEnabled
                            ? Colors.white
                            : Get.theme.primaryColor.withOpacity(0.7),
                        fontSize: 18,
                      )),
                  onPressed: () {
                    controller.login();
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                child: Text(
                  "Mot de passe oublié ?".tr,
                  style: TextStyle(color: Get.theme.primaryColor, fontSize: 15),
                ),
                onTap: () {
                  Get.toNamed(Routes.FORGOT_PASSWORD);
                },
              ),
              SizedBox(height: Get.height * .2),
              Text(
                "Si vous n'avez pas encore de compte, cliquez ici.".tr,
                style: TextStyle(color: Get.theme.primaryColor, fontSize: 15),
              ),
              SizedBox(
                height: 10,
              ),
              PrimaryButton(
                width: double.infinity,
                backgroundColor: Colors.white,
                borderColor: Colors.grey[200],
                child: Text("S'INSCRIRE".tr,
                    style: TextStyle(
                      color: Get.theme.primaryColor,
                      fontSize: 18,
                    )),
                onPressed: () {
                  Get.toNamed(Routes.REGISTER);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
