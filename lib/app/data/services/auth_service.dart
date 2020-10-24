import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:naoty/app/data/models/user_model.dart';
import 'package:naoty/app/data/providers/api.dart';
import 'package:naoty/app/data/repositories/note_repository.dart';
import 'package:naoty/app/routes/app_pages.dart';
import 'package:naoty/app/tools/tools.dart';
import 'package:naoty/app/widgets/alert_popup.dart';

class AuthService extends GetxService {
  final NoteRepository repository = NoteRepository(apiClient: ApiClient(httpClient: http.Client()));
 
  final GetStorage token = GetStorage();
  
  Rx<Status> _status = Status.Uninitialized.obs;
  Status get status => this._status.value;
  set status(value) => this._status.value = value;
  
  
  Rx<UserModel> _currentUser = UserModel().obs;
  UserModel get currentUser => this._currentUser.value;
  set currentUser(value) => this._currentUser.value = value;
  
  @override
  void onReady() {
    isLoggedIn();
    token.listenKey(tokenBox, (token){
      print(token);
      if(token != null) {
        status = Status.Authenticated;
      }else {
        status = Status.Unauthenticated;
      }
    });
    super.onReady();
  }

  isLoggedIn() async {
    String t = token.read(tokenBox);
    if(t != null) {
      status = Status.Authenticated;
    }else {
      status = Status.Unauthenticated;
    }
  }
  
  login(String identity, String password) {
    showLoadingDialog();
    repository.login(identity, password).then((value) {
      closeLoadingDialog();
      currentUser = value;
      token.write(tokenBox, currentUser.jwt);
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
      Get.offAllNamed(Routes.HOME);
    }).catchError((onError) {
      closeLoadingDialog();
      Get.dialog(
        AlertPopup(
          isError: true,
          title: "Erreur connexion",
          content: onError.toString(),
          onCanceled: () {
            Get.back();
          },
        ),
      );
    });
  }

  Future forgotPasswored(String identity) {
    return repository.forgotPasswored(identity);
  }

  Future<void> signOut() async {
    return Future.wait([
      token.write(tokenBox, null),
      Get.offAllNamed(Routes.LOGIN),
    ]);
  }
}

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }