import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:naoty/app/data/models/user_model.dart';
import 'package:naoty/app/data/repositories/note_repository.dart';
import 'package:naoty/app/routes/app_pages.dart';
import 'package:naoty/app/tools/tools.dart';
import 'package:naoty/app/widgets/alert_popup.dart';

class AuthService extends GetxService {
  final NoteRepository repository = NoteRepository();

  final GetStorage token = GetStorage();
  final GetStorage user = GetStorage();

  Rx<Status> _status = Status.Uninitialized.obs;
  Status get status => this._status.value;
  set status(value) => this._status.value = value;

  Rx<UserModel> _currentUser = UserModel().obs;
  UserModel get currentUser => this._currentUser.value;
  set currentUser(value) => this._currentUser.value = value;

  @override
  void onReady() {
    isLoggedIn();
    token.listenKey(tokenBox, (token) {
      if (token != null) {
        status = Status.Authenticated;
      } else {
        status = Status.Unauthenticated;
      }
    });
    super.onReady();
  }

  isLoggedIn() async {
    String? t = token.read(tokenBox);
    if (t != null) {
      status = Status.Authenticated;
    } else {
      status = Status.Unauthenticated;
    }
  }

  login(String identity, String password) {
    showLoadingDialog();
    repository.login(identity, password).then((value) {
      closeLoadingDialog();
      currentUser = value;
      token.write(tokenBox, currentUser.jwt);
      user.write(userBox, currentUser.user!.toJson());
      Get.offAllNamed(Routes.HOME);
    }).catchError((onError) {
      closeLoadingDialog();
      Get.dialog(
        AlertPopup(
          isError: true,
          title: "Erreur",
          content: onError.toString(),
          onCanceled: () {
            Get.back();
          },
        ),
      );
    });
  }

  register(String username, String password, String email) {
    showLoadingDialog();
    repository.register(username, email, password).then((value) {
      closeLoadingDialog();
      currentUser = value;
      token.write(tokenBox, currentUser.jwt);
      user.write(userBox, currentUser.user!.toJson());
      Get.offAllNamed(Routes.HOME);
    }).catchError((onError) {
      closeLoadingDialog();
      Get.dialog(
        AlertPopup(
          isError: true,
          title: "Erreur",
          content: onError.toString(),
          onCanceled: () {
            Get.back();
          },
        ),
      );
    });
  }

  Future forgotPassword(String identity) {
    return repository.forgotPassword(identity);
  }

  Future resetPassword(
      String code, String password, String passwordConfirmation) {
    showLoadingDialog();
    return repository
        .resetPassword(code, password, passwordConfirmation)
        .then((value) {
      closeLoadingDialog();
      currentUser = value;
      token.write(tokenBox, currentUser.jwt);
      user.write(userBox, currentUser.user!.toJson());
      Get.offAllNamed(Routes.HOME);
    }).catchError((onError) {
      closeLoadingDialog();
      Get.dialog(
        AlertPopup(
          isError: true,
          title: "Erreur",
          content: onError.toString(),
          onCanceled: () {
            Get.back();
          },
        ),
      );
    });
  }

  Future signOut() async {
    return Future.wait([
      token.erase(),
      user.erase(),
      Get.offAllNamed(Routes.LOGIN)!.then((value) => value!),
    ]);
  }
}

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }
