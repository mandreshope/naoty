import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:naoty/app/data/providers/api.dart';
import 'package:naoty/app/data/repositories/note_repository.dart';

import 'forgot_password_controller.dart';

class ForgotPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut< ForgotPasswordController>(() => ForgotPasswordController(
    repository: NoteRepository(
    apiClient: ApiClient(httpClient: http.Client()))));
  }
}