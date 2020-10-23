import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:naoty/app/data/repositories/note_repository.dart';

class RegisterController extends GetxController {

  final NoteRepository repository;
  RegisterController({@required this.repository}) : assert(repository != null);

  RxBool loginPageObscureTextState = true.obs;
  RxBool registerPageObscureTextState = true.obs;
  
  void onLoginPageOscureTextTapped() {
    loginPageObscureTextState.value = !loginPageObscureTextState.value;
  }
  void onRegisterPageOscureTextTapped() {
    registerPageObscureTextState.value = !registerPageObscureTextState.value;
  }

  TextEditingController password = TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController email = TextEditingController();

  RxBool _isButtonEnabled = false.obs;
  bool get isButtonEnabled => this._isButtonEnabled.value;
  set isButtonEnabled(value) => this._isButtonEnabled.value = value;

  
  RxString _errorMessage = ''.obs;
  String get errorMessage => this._errorMessage.value;
  set errorMessage(value) => this._errorMessage.value = value;

  
  final _passworedErrorMessage = ''.obs;
  get passworedErrorMessage => this._passworedErrorMessage.value;
  set passworedErrorMessage(value) => this._passworedErrorMessage.value = value;
  
  
  
  
  RxBool _obscureText = true.obs;
  bool get obscureText => this._obscureText.value;
  set obscureText(value) => this._obscureText.value = value;

  register() {
    if(isButtonEnabled) {
      
    }
  }

  isTextFieldEmpty() {
    if ((password.text.trim() != "")
      && (password.text.length >=8)
      && (fullName.text.trim() != "")
      && (email.text.trim() != "")
      && (email.text.isEmail) 
    ) {
        isButtonEnabled = true;
    } else {
        isButtonEnabled = false;
    }
  }

  @override
  void onInit() {
    isTextFieldEmpty();
    super.onInit();
  }
}