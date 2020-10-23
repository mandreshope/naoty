import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:naoty/app/data/repositories/note_repository.dart';

class ForgotPasswordController extends GetxController {

  final NoteRepository repository;
  ForgotPasswordController({@required this.repository}) : assert(repository != null);
  
  TextEditingController identifiantController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  
  RxBool _isButtonEnabled = false.obs;
  bool get isButtonEnabled => this._isButtonEnabled.value;
  set isButtonEnabled(value) => this._isButtonEnabled.value = value;

  @override
  void onInit() {
    isTextFieldEmpty();
    super.onInit();
  }

  isTextFieldEmpty() {
    if ((identifiantController.text.trim() != "")) {
        isButtonEnabled = true;
    } else {
        isButtonEnabled = false;
    }
  }

  resetPassword() {
    
  }

  @override
  void onClose() {
    identifiantController.dispose();
    passwordController.dispose();
    super.onClose();
  }

}