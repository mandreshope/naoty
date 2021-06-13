import 'package:get/get.dart';
import 'package:naoty/app/data/repositories/note_repository.dart';
import 'package:naoty/app/modules/editor/editor_controller.dart';

class EditorBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditorController>(
        () => EditorController(repository: NoteRepository()));
  }
}
