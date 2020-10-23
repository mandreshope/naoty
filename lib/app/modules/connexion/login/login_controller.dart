import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:naoty/app/data/repositories/note_repository.dart';

class LoginController extends GetxController {

  final NoteRepository repository;
  LoginController({@required this.repository}) : assert(repository != null);
  
  TextEditingController emailController = TextEditingController();
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
    if ((emailController.text.trim() != "") && (passwordController.text.trim() != "")) {
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
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  login() {
    if(isButtonEnabled) {
      
    } 
  }

}