import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naoty/app/data/services/auth_service.dart';
import 'package:naoty/app/tools/tools.dart';
import 'package:naoty/app/widgets/alert_popup.dart';

class ForgotPasswordController extends GetxController {

  AuthService authService = Get.find<AuthService>();
  
  TextEditingController emailController = TextEditingController();
  
  RxBool _isButtonEnabled = false.obs;
  bool get isButtonEnabled => this._isButtonEnabled.value;
  set isButtonEnabled(value) => this._isButtonEnabled.value = value;

  @override
  void onInit() {
    isTextFieldEmpty();
    super.onInit();
  }

  isTextFieldEmpty() {
    if ((emailController.text.trim() != "")) {
        isButtonEnabled = true;
    } else {
        isButtonEnabled = false;
    }
  }

  resetPassword() {
    showLoadingDialog();
    authService.forgotPasswored(emailController.text)
    .then((value) {
      closeLoadingDialog();
      Get.dialog(
        AlertPopup(
          isError: false,
          title: "Réussi",
          content: "Un lien de récupération mot de passe a été envoyé à ${emailController.text}.",
          onCanceled: () {
            Get.back();
          },
        ),
      );
    })
    .catchError((onError) {
      closeLoadingDialog();
      Get.dialog(
        AlertPopup(
          isError: true,
          title: "Erreur",
          content: onError.toString(),
          onCanceled: () {
            Get.back();
          },
        ),
      );
    });
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

}