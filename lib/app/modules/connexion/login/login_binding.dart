import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:naoty/app/data/providers/api.dart';
import 'package:naoty/app/data/repositories/note_repository.dart';
import 'package:naoty/app/modules/connexion/login/login_controller.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut< LoginController>(() => LoginController(
      repository: NoteRepository(
      apiClient: ApiClient(httpClient: http.Client()))));
  }
}