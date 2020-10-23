import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:naoty/app/data/models/note_model.dart';
import 'package:naoty/app/data/repositories/note_repository.dart';
import 'package:naoty/app/routes/app_pages.dart';
import 'package:naoty/app/widgets/alert_popup.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeController extends GetxController {

  final NoteRepository repository;
  HomeController({@required this.repository}) : assert(repository != null);

  
  RxList<NoteModel> _notes = <NoteModel>[].obs;
  RxList<NoteModel> get notes => this._notes;
  set notes(value) => this._notes.value = value;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  NoteModel note;

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

  goToEditor(index) {
    note = notes[index];
    Get.toNamed(Routes.EDITOR)
    .then((value) => getAll());
  }

  create() {
    note = null;
    Get.toNamed(Routes.EDITOR)
    .then((value) => getAll());
  }

  Future getAll() {
    return repository.getAll()
    .then((value){
      notes.clear();
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

  void onRefresh() async{
    // monitor network fetch
    await getAll();
    // if failed,use refreshFailed()
    refreshController.refreshCompleted();
  }

  void onLoading() async{
    // monitor network fetch
    await getAll();
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    refreshController.loadComplete();
  }
  
}