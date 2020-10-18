import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:naoty/app/data/providers/api.dart';
import 'package:naoty/app/data/repositories/note_repository.dart';
import 'package:naoty/app/modules/editor/editor_controller.dart';

class EditorBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut< EditorController>(() => EditorController(
      repository: NoteRepository(
      apiClient: ApiClient(httpClient: http.Client()))));
  }
}