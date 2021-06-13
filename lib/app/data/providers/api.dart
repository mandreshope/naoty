import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:naoty/app/data/models/me_model.dart';
import 'package:naoty/app/data/models/note_model.dart';
import 'package:naoty/app/data/models/user_model.dart';
import 'package:naoty/app/data/providers/base_provider.dart';
import 'package:naoty/app/data/providers/end_point.dart';

class ApiClient extends BaseProvider {
  final GetStorage token = GetStorage();
  Duration timeout = Duration(minutes: 1);

  Future getAll(String? userId, int limit) async {
    try {
      Response<List<NoteModel>> response = await get(
          "${EndPoint.notes}?users_permissions_user=$userId&_limit=$limit&_sort=createdAt:DESC",
          decoder: (body) {
        Iterable iterable = body;
        List<NoteModel> decoder =
            iterable.map((model) => NoteModel.fromJson(model)).toList();
        return decoder;
      });
      if (response.hasError) {
        throw HttpException(response.statusText!);
      } else {
        return response.body!;
      }
    } on TimeoutException catch (_) {
      throw "Le délai d'attente est dépassé.";
    } on SocketException catch (_) {
      throw "Veuillez vérifier votre connexion Internet.";
    } on Error catch (_) {
      throw _.toString();
    } catch (_) {
      throw _.toString();
    }
  }

  Future me() async {
    try {
      Response<MeModel> response = await get("${EndPoint.me}", decoder: (body) {
        MeModel decoder = MeModel.fromJson(body);
        return decoder;
      });
      if (response.hasError) {
        throw HttpException(response.statusText!);
      } else {
        return response.body!;
      }
    } on TimeoutException catch (_) {
      throw "Le délai d'attente est dépassé.";
    } on SocketException catch (_) {
      throw "Veuillez vérifier votre connexion Internet.";
    } on Error catch (_) {
      throw _.toString();
    } catch (_) {
      throw _.toString();
    }
  }

  Future getUser(String id) async {
    try {
      Response<MeModel> response =
          await get("${EndPoint.user}$id", decoder: (body) {
        MeModel decoder = MeModel.fromJson(body);
        return decoder;
      });
      if (response.hasError) {
        throw HttpException(response.statusText!);
      } else {
        return response.body!;
      }
    } on TimeoutException catch (_) {
      throw "Le délai d'attente est dépassé.";
    } on SocketException catch (_) {
      throw "Veuillez vérifier votre connexion Internet.";
    } on Error catch (_) {
      throw _.toString();
    } catch (_) {
      throw _.toString();
    }
  }

  Future deleteNote(id) async {
    try {
      Response<dynamic> response = await delete(
        '${EndPoint.notes}$id',
      );
      if (response.hasError) {
        throw HttpException(response.statusText!);
      } else {
        return response.body!;
      }
    } on TimeoutException catch (_) {
      throw "Le délai d'attente est dépassé.";
    } on SocketException catch (_) {
      throw "Veuillez vérifier votre connexion Internet.";
    } on Error catch (_) {
      throw _.toString();
    } catch (_) {
      throw _.toString();
    }
  }

  Future edit(String? id, String content) async {
    try {
      Response<NoteModel> response = await put(
          "${EndPoint.notes}$id", {'content': content}, decoder: (body) {
        NoteModel decoder = NoteModel.fromJson(body);
        return decoder;
      });
      if (response.hasError) {
        throw HttpException(response.statusText!);
      } else {
        return response.body!;
      }
    } on TimeoutException catch (_) {
      throw "Le délai d'attente est dépassé.";
    } on SocketException catch (_) {
      throw "Veuillez vérifier votre connexion Internet.";
    } on Error catch (_) {
      throw _.toString();
    } catch (_) {
      throw _.toString();
    }
  }

  Future add(String content, String? userId) async {
    try {
      Response<NoteModel> response = await post("${EndPoint.notes}", {
        'content': content,
        "users_permissions_user": userId
      }, decoder: (body) {
        NoteModel decoder = NoteModel.fromJson(body);
        return decoder;
      });
      if (response.hasError) {
        throw HttpException(response.statusText!);
      } else {
        return response.body!;
      }
    } on TimeoutException catch (_) {
      throw "Le délai d'attente est dépassé.";
    } on SocketException catch (_) {
      throw "Veuillez vérifier votre connexion Internet.";
    } on Error catch (_) {
      throw _.toString();
    } catch (_) {
      throw _.toString();
    }
  }

  Future login(String identifier, String password) async {
    try {
      Response<UserModel> response = await post("${EndPoint.login}", {
        'identifier': identifier,
        'password': password,
      }, decoder: (body) {
        UserModel decoder = UserModel.fromJson(body);
        return decoder;
      });
      if (response.hasError) {
        if (response.statusCode == 400) {
          throw "Identifiant ou mot de passe invalide.";
        }
        throw HttpException(response.statusText!);
      } else {
        return response.body!;
      }
    } on TimeoutException catch (_) {
      throw "Le délai d'attente est dépassé.";
    } on SocketException catch (_) {
      throw "Veuillez vérifier votre connexion Internet.";
    } on Error catch (_) {
      throw _.toString();
    } catch (_) {
      throw _.toString();
    }
  }

  Future register(String username, String email, String password) async {
    try {
      Response<UserModel> response = await post("${EndPoint.register}", {
        'username': username,
        'email': email,
        'password': password,
      }, decoder: (body) {
        UserModel decoder = UserModel.fromJson(body);
        return decoder;
      });
      if (response.hasError) {
        throw HttpException(response.statusText!);
      } else {
        return response.body!;
      }
    } on TimeoutException catch (_) {
      throw "Le délai d'attente est dépassé.";
    } on SocketException catch (_) {
      throw "Veuillez vérifier votre connexion Internet.";
    } on Error catch (_) {
      throw _.toString();
    } catch (_) {
      throw _.toString();
    }
  }

  Future forgotPassword(String email) async {
    try {
      Response response = await post("${EndPoint.forgotPassword}", {
        'email': email,
      }, decoder: (body) {
        print(body);
      });
      if (response.hasError) {
        throw HttpException(response.statusText!);
      } else {
        return response.body!;
      }
    } on TimeoutException catch (_) {
      throw "Le délai d'attente est dépassé.";
    } on SocketException catch (_) {
      throw "Veuillez vérifier votre connexion Internet.";
    } on Error catch (_) {
      throw _.toString();
    } catch (_) {
      throw _.toString();
    }
  }

  Future resetPassword(
      String code, String password, String passwordConfirmation) async {
    try {
      Response<UserModel> response = await post("${EndPoint.resetPassword}", {
        'code': code,
        'password': password,
        'passwordConfirmation': passwordConfirmation
      }, decoder: (body) {
        UserModel decoder = UserModel.fromJson(body);
        return decoder;
      });
      if (response.hasError) {
        throw HttpException(response.statusText!);
      } else {
        return response.body!;
      }
    } on TimeoutException catch (_) {
      throw "Le délai d'attente est dépassé.";
    } on SocketException catch (_) {
      throw "Veuillez vérifier votre connexion Internet.";
    } on Error catch (_) {
      throw _.toString();
    } catch (_) {
      throw _.toString();
    }
  }
}
