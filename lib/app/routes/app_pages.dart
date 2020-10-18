import 'package:get/get.dart';
import 'package:naoty/app/modules/about/about_binding.dart';
import 'package:naoty/app/modules/about/about_view.dart';
import 'package:naoty/app/modules/editor/editor_binding.dart';
import 'package:naoty/app/modules/editor/editor_view.dart';
import 'package:naoty/app/modules/home/home_binding.dart';
import 'package:naoty/app/modules/home/home_view.dart';
part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.HOME, 
      page:()=> HomeView(), 
      binding: HomeBinding()
    ),
    GetPage(
      name: Routes.ABOUT, 
      page:()=> AboutView(), 
      binding: AboutBinding()
    ),
    GetPage(
      name: Routes.EDITOR, 
      page:()=> EditorView(), 
      binding: EditorBinding()
    ),
  ];
}