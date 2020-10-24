import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naoty/app/data/services/auth_service.dart';

class LoginController extends GetxController {

  AuthService authService = Get.find<AuthService>();
  
  TextEditingController identifierController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  
  RxBool _isButtonEnabled = false.obs;
  get isButtonEnabled => this._isButtonEnabled.value;
  set isButtonEnabled(value) => this._isButtonEnabled.value = value;
  
  
  RxBool _obscureText = true.obs;
  bool get obscureText => this._obscureText.value;
  set obscureText(value) => this._obscureText.value = value;
  

  @override
  void onInit() {
    isTextFieldEmpty();
    super.onInit();
  }

  isTextFieldEmpty() {
    if ((identifierController.text.trim() != "") && (passwordController.text.trim() != "")) {
        isButtonEnabled = true;
    } else {
        isButtonEnabled = false;
    }
  }

  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    identifierController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  login() {
    if(isButtonEnabled) {
      authService.login(identifierController.text, passwordController.text);
    } 
  }

}