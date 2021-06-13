import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:naoty/app/data/models/note_model.dart';
import 'package:naoty/app/modules/home/home_controller.dart';
import 'package:package_info/package_info.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:naoty/app/routes/app_pages.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: GetBuilder<HomeController>(
            init: controller,
            builder: (_) => controller.selectionIsActive
                ? Text("Élément sélectionné : ${controller.noteIdList.length}")
                : Text("Naoty")),
        actions: [
          GetBuilder<HomeController>(
            init: controller,
            builder: (_) => Row(
              children: [
                if (controller.selectionIsActive) ...[
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      controller.delete();
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.undo),
                    onPressed: () {
                      controller.clear();
                    },
                  ),
                  SizedBox(
                    width: 10,
                  )
                ] else ...[
                  Builder(
                    builder: (ctx) => IconButton(
                      icon: Icon(Icons.menu),
                      onPressed: () {
                        Scaffold.of(ctx).openEndDrawer();
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  )
                ]
              ],
            ),
          )
        ],
      ),
      body: GetBuilder<HomeController>(
        init: controller,
        builder: (_) => controller.showLoader
            ? Center(
                child: CircularProgressIndicator(),
              )
            : controller.notes.isEmpty
                ? Center(child: Text("Vous n'avez pas des notes"))
                : SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: true,
                    header: WaterDropMaterialHeader(),
                    footer: CustomFooter(
                      builder: (BuildContext context, LoadStatus? mode) {
                        Widget body;
                        if (mode == LoadStatus.idle) {
                          body = Container();
                        } else if (mode == LoadStatus.loading) {
                          body = SizedBox(
                              height: 20.0,
                              width: 20.0,
                              child:
                                  CircularProgressIndicator(strokeWidth: 2.0));
                        } else if (mode == LoadStatus.failed) {
                          body = Text("Load Failed!Click retry!");
                        } else if (mode == LoadStatus.canLoading) {
                          body = Text("Relâchez pour charger plus de données");
                        } else {
                          body = Text("Plus de données");
                        }
                        return Container(
                          height: 55.0,
                          child: Center(child: body),
                        );
                      },
                    ),
                    controller: controller.refreshController,
                    onRefresh: controller.onRefresh,
                    onLoading: controller.onLoading,
                    child: StaggeredGridView.countBuilder(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      crossAxisCount: 4,
                      itemCount: controller.notes.length,
                      itemBuilder: (BuildContext context, int index) {
                        NoteModel note = controller.notes[index];
                        return Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: note.isSelected
                                  ? Get.theme.primaryColor
                                  : Colors.transparent,
                              width: 2,
                            ),
                            boxShadow: note.isSelected
                                ? []
                                : [
                                    BoxShadow(
                                      color: Colors.grey[200]!,
                                      offset: Offset(0, 2),
                                      blurRadius: 5,
                                    )
                                  ],
                            color: Colors.white,
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: GestureDetector(
                              child: InkWell(
                                borderRadius: BorderRadius.circular(10),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 25,
                                    vertical: 20,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        note.content!.length >= 286
                                            ? note.content!.substring(0, 286)
                                            : controller.notes[index].content ??
                                                "",
                                        style: TextStyle(
                                          fontSize: 17,
                                        ),
                                      ),
                                      Divider(),
                                      Text(
                                        DateFormat.yMMMMd('fr_FR').format(
                                          DateTime.parse(
                                            controller.notes[index].createdAt!,
                                          ),
                                        ),
                                        style: TextStyle(
                                          color: Get.theme.primaryColor
                                              .withOpacity(0.5),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  if (controller.selectionIsActive) {
                                    note.isSelected =
                                        !controller.notes[index].isSelected;
                                    if (controller.notes[index].isSelected) {
                                      controller.noteIdList.add(note.id);
                                    } else {
                                      controller.noteIdList
                                          .removeWhere((v) => v == note.id);
                                      if (controller.noteIdList.isEmpty) {
                                        controller.selectionIsActive = false;
                                      }
                                    }
                                  } else {
                                    controller.goToEditor(index);
                                  }
                                  print(controller.noteIdList.length);
                                  controller.update();
                                },
                              ),
                              onLongPress: () {
                                note.isSelected = !note.isSelected;
                                if (controller.notes[index].isSelected) {
                                  controller.selectionIsActive = true;
                                  controller.noteIdList.add(note.id);
                                } else {
                                  controller.noteIdList
                                      .removeWhere((v) => v == note.id);
                                  if (controller.noteIdList.isEmpty) {
                                    controller.selectionIsActive = false;
                                  }
                                }
                                print(controller.noteIdList.length);
                              },
                            ),
                          ),
                        );
                      },
                      staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
                      mainAxisSpacing: 15.0,
                      crossAxisSpacing: 15.0,
                    ),
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          controller.create();
        },
      ),
      endDrawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.white,
        ),
        child: Drawer(
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.person,
                      color: Get.theme.primaryColor,
                    ),
                    title: Text(
                      controller.user?.username ?? "...",
                      style: TextStyle(
                        color: Get.theme.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.info,
                      color: Get.theme.primaryColor,
                    ),
                    title: Text(
                      "A propos",
                      style: TextStyle(
                        color: Get.theme.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Get.back();
                      Get.toNamed(Routes.ABOUT);
                    },
                  ),
                  FutureBuilder(
                    future: PackageInfo.fromPlatform(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return ListTile(
                          leading: Icon(
                            Icons.update,
                            color: Get.theme.primaryColor,
                          ),
                          title: Text(
                            "version : ${snapshot.data.version} (${snapshot.data.buildNumber})",
                            style: TextStyle(
                              color: Get.theme.primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                  SizedBox(height: Get.height * .6),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.logout, color: Get.theme.primaryColor),
                    title: Text(
                      "Déconnexion",
                      style: TextStyle(
                          color: Get.theme.primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Get.back();
                      controller.authService.signOut();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
