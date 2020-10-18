import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:naoty/app/data/models/note_model.dart';
import 'package:naoty/app/data/repositories/note_repository.dart';
import 'package:naoty/app/widgets/alert_popup.dart';

class HomeController extends GetxController {

  final NoteRepository repository;
  HomeController({@required this.repository}) : assert(repository != null);

  
  RxList<NoteModel> _notes = <NoteModel>[].obs;
  RxList<NoteModel> get notes => this._notes;
  set notes(value) => this._notes.value = value;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    getAll();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getAll() {
    repository.getAll()
    .then((value){
      notes.addAll(value);
    })
    .catchError((onError) {
      print(onError);
      Get.dialog(
        AlertPopup(
          isError: true,
          title: "Error",
          content: onError.toString(),
          onCanceled: () {
            Get.back();
          },
        )
      );
    });
  }
  
}