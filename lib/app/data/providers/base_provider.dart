import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:naoty/app/tools/tools.dart';

const baseUrl = 'https://strapi-naoty.herokuapp.com';

class BaseProvider extends GetConnect {
  final GetStorage getStorage = GetStorage();
  @override
  void onInit() {
    httpClient.baseUrl = baseUrl;
    httpClient.addRequestModifier<void>((request) {
      print("${this.runtimeType} ${request.method} : ${request.url}");
      String? token = getStorage.read<String>(tokenBox);
      // Set the header
      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token';
      }
      return request;
    });

    httpClient.timeout = Duration(seconds: 10);

    super.onInit();
  }
}
