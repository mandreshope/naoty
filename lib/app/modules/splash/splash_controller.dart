import 'package:get/get.dart';
import 'package:naoty/app/data/services/auth_service.dart';
import 'package:naoty/app/routes/app_pages.dart';

class SplashController extends GetxController {
  AuthService authService = Get.find<AuthService>();
  @override
  void onReady() {
    if(authService.status == Status.Authenticated) {
      Get.offAllNamed(Routes.HOME);
    }else{
      Get.offAllNamed(Routes.LOGIN);
    }
    super.onReady();
  }
}