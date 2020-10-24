import 'package:get/get.dart';
import 'package:naoty/app/modules/connexion/reset_password/reset_password_controller.dart';

class ResetPasswordBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut< ResetPasswordController>(() => ResetPasswordController());
  }
}