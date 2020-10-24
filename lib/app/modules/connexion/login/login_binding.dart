import 'package:get/get.dart';
import 'package:naoty/app/modules/connexion/login/login_controller.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut< LoginController>(() => LoginController());
  }
}