import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:naoty/app/data/models/note_model.dart';
import 'package:naoty/app/data/models/user_model.dart';
import 'package:naoty/app/data/repositories/note_repository.dart';
import 'package:naoty/app/data/services/auth_service.dart';
import 'package:naoty/app/routes/app_pages.dart';
import 'package:naoty/app/tools/tools.dart';
import 'package:naoty/app/widgets/alert_popup.dart';
import 'package:naoty/app/widgets/confirm_dialog.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeController extends GetxController {
  final NoteRepository repository;
  HomeController({required this.repository});

  AuthService authService = Get.find<AuthService>();

  List<NoteModel> _notes = <NoteModel>[];
  List<NoteModel> get notes => this._notes;
  set notes(value) {
    this._notes = value;
    update();
  }

  User? user = User.fromJson(GetStorage().read(userBox));

  bool _selectionIsActive = false;
  bool get selectionIsActive => this._selectionIsActive;
  set selectionIsActive(bool value) {
    this._selectionIsActive = value;
    update();
  }

  List<String?> _noteIdList = <String>[];
  List<String?> get noteIdList => this._noteIdList;
  set noteIdList(value) {
    this._noteIdList = value;
    update();
  }

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  bool showLoader = false;
  set setShowLoader(bool value) {
    showLoader = value;
    update();
  }

  NoteModel? note;

  int limit = 10;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  onReady() {
    initNotes();
    super.onReady();
  }

  initNotes() {
    setShowLoader = true;
    return repository.getAll(user?.id, limit).then((value) {
      clear();
      notes.clear();
      notes.addAll(value);
      setShowLoader = false;
    }).catchError((onError) {
      print(onError);
      setShowLoader = false;
      Get.dialog(AlertPopup(
        isError: true,
        title: "Error",
        content: onError.toString(),
        onCanceled: () {
          Get.back();
        },
      ));
    });
  }

  @override
  void onClose() {
    super.onClose();
  }

  goToEditor(index) {
    note = notes[index];
    Get.toNamed(Routes.EDITOR)!.then((value) => getAll(pullDown: true));
  }

  clear() {
    noteIdList.clear();
    selectionIsActive = false;
    notes.where((note) => note.isSelected == true).forEach((element) {
      element.isSelected = false;
    });
    update();
  }

  delete() {
    Get.dialog(ConfirmDialog(
      title: "Supprimer",
      content: noteIdList.length <= 1
          ? "Voulez-vous supprimer cette note ?"
          : "Voulez-vous supprimer ${noteIdList.length} notes ?",
      onAccepted: () {
        Get.back();
        showLoadingDialog();
        noteIdList.forEach((id) => repository.delete(id).then((value) {
              clear();
              getAll(pullDown: true)
                  .then((value) => closeLoadingDialog())
                  .catchError((onError) {
                closeLoadingDialog();
              });
            }).catchError((onError) {
              closeLoadingDialog();
              Get.dialog(AlertPopup(
                isError: true,
                title: "Error",
                content: onError.toString(),
                onCanceled: () {
                  Get.back();
                },
              ));
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
    Get.toNamed(Routes.EDITOR)!.then((value) => getAll(pullDown: true));
  }

  Future getAll({required bool pullDown}) {
    if (pullDown) {
      limit = 10;
    } else {
      limit += 10;
    }
    return repository.getAll(user?.id, limit).then((value) {
      clear();
      notes.clear();
      notes.addAll(value);
    }).catchError((onError) {
      print(onError);
      Get.dialog(AlertPopup(
        isError: true,
        title: "Error",
        content: onError.toString(),
        onCanceled: () {
          Get.back();
        },
      ));
    });
  }

  void onRefresh() async {
    refreshController.requestRefresh();
    // monitor network fetch
    if (refreshController.footerStatus == LoadStatus.loading) {
      await getAll(pullDown: false);
    } else if (refreshController.headerStatus == RefreshStatus.refreshing) {
      await getAll(pullDown: true);
    }

    // if failed,use refreshFailed()
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    // monitor network fetch
    if (refreshController.footerMode!.value == LoadStatus.loading) {
      await getAll(pullDown: false);
    } else if (refreshController.headerStatus == RefreshStatus.refreshing) {
      await getAll(pullDown: true);
    }
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    refreshController.loadComplete();
  }
}
