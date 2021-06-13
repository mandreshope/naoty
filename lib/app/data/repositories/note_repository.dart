import 'package:get/get.dart';
import 'package:naoty/app/data/providers/api.dart';

class NoteRepository {
  final ApiClient apiClient = Get.find();

  Future getAll(String? userId, int limit) {
    return apiClient.getAll(userId, limit);
  }

  Future delete(id) {
    return apiClient.deleteNote(id);
  }

  Future edit(String? id, String content) {
    return apiClient.edit(id, content);
  }

  Future add(String content, String? userId) {
    return apiClient.add(content, userId);
  }

  Future me() {
    return apiClient.me();
  }

  Future getUser(String id) {
    return apiClient.getUser(id);
  }

  Future login(String identifier, String password) {
    return apiClient.login(identifier, password);
  }

  Future register(String username, String email, String password) {
    return apiClient.register(username, email, password);
  }

  Future forgotPassword(String email) {
    return apiClient.forgotPassword(email);
  }

  Future resetPassword(
      String code, String password, String passwordConfirmation) {
    return apiClient.resetPassword(code, password, passwordConfirmation);
  }
}
