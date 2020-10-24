import 'package:meta/meta.dart';
import 'package:naoty/app/data/providers/api.dart';

class NoteRepository {

final ApiClient apiClient;

NoteRepository({@required this.apiClient}) : assert(apiClient != null);

  Future getAll(){
    return apiClient.getAll();
  }

  Future getId(id){
    return apiClient.getId(id);
  }

  Future delete(id){
    return apiClient.delete(id);
  }

  Future edit(String id, String content){
    return apiClient.edit(id, content);
  }

  Future add(String content, String userId){
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

  Future resetPassword(String code, String password, String passwordConfirmation) {
    return apiClient.resetPassword(code, password, passwordConfirmation);
  }

}