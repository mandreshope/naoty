import 'package:get/get.dart';
import 'package:naoty/app/modules/about/about_controller.dart';

class AboutBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut< AboutController>(() => AboutController());
  }
}