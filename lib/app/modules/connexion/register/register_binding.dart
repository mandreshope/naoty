import 'package:get/get.dart';
import 'package:naoty/app/data/repositories/note_repository.dart';
import 'package:naoty/app/modules/connexion/register/register_controller.dart';

class RegisterBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(
        () => RegisterController(repository: NoteRepository()));
  }
}
