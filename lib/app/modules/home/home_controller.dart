import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:naoty/app/data/models/me_model.dart';
import 'package:naoty/app/data/models/note_model.dart';
import 'package:naoty/app/data/repositories/note_repository.dart';
import 'package:naoty/app/data/services/auth_service.dart';
import 'package:naoty/app/routes/app_pages.dart';
import 'package:naoty/app/tools/tools.dart';
import 'package:naoty/app/widgets/alert_popup.dart';
import 'package:naoty/app/widgets/confirm_dialog.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeController extends GetxController {

  final NoteRepository repository;
  HomeController({@required this.repository}) : assert(repository != null);

  AuthService authService = Get.find<AuthService>();
  
  RxList<NoteModel> _notes = <NoteModel>[].obs;
  RxList<NoteModel> get notes => this._notes;
  set notes(value) => this._notes.value = value;

  Rx<MeModel> _me = MeModel().obs;
  MeModel get me => this._me.value;
  set me(value) => this._me.value = value;

  
  RxBool _selectionIsActive = false.obs;
  bool get selectionIsActive => this._selectionIsActive.value;
  set selectionIsActive(value) => this._selectionIsActive.value = value;

  
  RxList<String> _noteIdList = <String>[].obs;
  RxList<String> get noteIdList => this._noteIdList;
  set noteIdList(value) => this._noteIdList.value = value;
  
  

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  NoteModel note;

  int limit = 4;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  onReady() {
    getMe();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  goToEditor(index) {
    note = notes[index];
    Get.toNamed(Routes.EDITOR)
    .then((value) => onRefresh());
  }

  clear() {
    noteIdList.clear();
    selectionIsActive = false;
    notes.where((note) => note.isSelected.value == true).forEach((element) {
      element.isSelected.value = false;
    });
  }

  delete() {
    Get.dialog(ConfirmDialog(
      title: "Supprimer",
      content: noteIdList.length <= 1 ? "Voulez-vous supprimer cette note ?" :  "Voulez-vous supprimer ${noteIdList.length} notes ?",
      onAccepted: () {
        Get.back();
        showLoadingDialog();
        noteIdList.forEach((id)=>repository.delete(id)
        .then((value){
          clear();
          getAll(pullDown: true).then((value) => closeLoadingDialog())
          .catchError((onError) {
            closeLoadingDialog();
          });
        }).catchError((onError) {
          closeLoadingDialog();
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
        }));
      },
      onCanceled: () {
        Get.back();
      },
    ));
  }

  create() {
    note = null;
    clear();
    Get.toNamed(Routes.EDITOR)
    .then((value) => onRefresh());
  }

  Future getMe() {
    return repository.me().then((value) {
      me = value;
      getAll(pullDown: true);
    });
  }

  Future getAll({@required bool pullDown}) {
    if(pullDown) {
      limit = 6;
    }else {
      limit += 2;
    }
    return repository.getAll(me.id, limit)
    .then((value){
      clear();
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
    refreshController.requestRefresh();
    // monitor network fetch
    if(refreshController.footerStatus ==LoadStatus.loading) {
      await getAll(pullDown: false);
    }else if(refreshController.headerStatus ==RefreshStatus.refreshing) {
      await getAll(pullDown: true);
    }
    
    // if failed,use refreshFailed()
    refreshController.refreshCompleted();
  }

  void onLoading() async{
    // monitor network fetch
    if(refreshController.footerMode.value ==LoadStatus.loading) {
      await getAll(pullDown: false);
    }else if(refreshController.headerStatus ==RefreshStatus.refreshing) {
      await getAll(pullDown: true);
    }
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    refreshController.loadComplete();
  }
  
}