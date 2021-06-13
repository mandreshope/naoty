import 'package:get/get.dart';
import 'package:naoty/app/data/repositories/note_repository.dart';
import 'package:naoty/app/modules/home/home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
        () => HomeController(repository: NoteRepository()));
  }
}
