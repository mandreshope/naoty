import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naoty/app/data/services/auth_service.dart';
import 'package:naoty/app/tools/tools.dart';
import 'package:naoty/app/widgets/alert_popup.dart';

class ResetPasswordController extends GetxController {

  AuthService authService = Get.find<AuthService>();
  
  TextEditingController codeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();
  
  RxBool _isButtonEnabled = false.obs;
  bool get isButtonEnabled => this._isButtonEnabled.value;
  set isButtonEnabled(value) => this._isButtonEnabled.value = value;

  @override
  void onInit() {
    isTextFieldEmpty();
    super.onInit();
  }

  isTextFieldEmpty() {
    if ((codeController.text.trim() != "") 
    && (passwordController.text.trim() != "") 
    && (cpasswordController.text.trim() != "")
    && (cpasswordController.text == passwordController.text)
    ) {
        isButtonEnabled = true;
    } else {
        isButtonEnabled = false;
    }
  }

  resetPassword() {
    if(!isButtonEnabled) {
      return;
    }
    authService.resetPassword(codeController.text, passwordController.text, cpasswordController.text);
  }

}