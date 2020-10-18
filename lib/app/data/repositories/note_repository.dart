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

  Future add(String content){
      return apiClient.add(content);
  }

}