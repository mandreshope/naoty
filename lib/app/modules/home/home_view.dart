import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
        actions: [
          Builder(builder: (ctx) =>IconButton(
            icon: Icon(Icons.menu), 
          onPressed: () {
            Scaffold.of(ctx).openEndDrawer();
          }),),
          SizedBox(width: 10,)
        ],
      ),
      body: Obx(()=> controller.notes.isEmpty ? Center(child: CircularProgressIndicator())
      : SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        header: WaterDropMaterialHeader(),
        footer: CustomFooter(
          builder: (BuildContext context,LoadStatus mode){
            Widget body;
            if(mode==LoadStatus.idle){
              body =  Text("pull up load");
            }
            else if(mode==LoadStatus.loading){
              body =  CupertinoActivityIndicator();
            }
            else if(mode == LoadStatus.failed){
              body = Text("Load Failed!Click retry!");
            }
            else if(mode == LoadStatus.canLoading){
                body = Text("release to load more");
            }
            else{
              body = Text("No more Data");
            }
            return Container(
              height: 55.0,
              child: Center(child:body),
            );
          },
        ),
        controller: controller.refreshController,
        onRefresh: controller.onRefresh,
        onLoading: controller.onLoading,
        child: StaggeredGridView.countBuilder(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          crossAxisCount: 4,
          itemCount: controller.notes.length,
          itemBuilder: (BuildContext context, int index) => Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(color: Colors.grey[200], offset: Offset(0, 5), blurRadius: 5)
              ],
              color: Colors.white
            ),
            child: Material(
                color: Colors.transparent,
                child: InkWell(
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(controller.notes[index].content.length >= 286 
                      ? controller.notes[index].content.substring(0, 286) 
                      : controller.notes[index].content ?? "", style: TextStyle(
                        fontSize: 17
                      ),),
                      Divider(),
                      Text(DateFormat.yMMMMd('fr_FR').format(DateTime.parse(controller.notes[index].createdAt))?? "", 
                        style: TextStyle(
                          color: Colors.grey
                        ),
                      ),
                    ],
                  )
                ),
                onTap: () {
                  controller.goToEditor(index);
                },
              )
            ),
          ),
          staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
          mainAxisSpacing: 15.0,
          crossAxisSpacing: 15.0,
        )
      )),
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
                    leading: Icon(Icons.info, color: Get.theme.primaryColor),
                    title: Text("A propos", style: TextStyle(
                        color: Get.theme.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    onTap: () {
                      Get.toNamed(Routes.ABOUT);
                    },
                  ),
                  FutureBuilder(
                    future: PackageInfo.fromPlatform(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if(snapshot.hasData) {
                        return ListTile(
                          leading: Icon(Icons.update, color: Get.theme.primaryColor),
                          title: Text("version : ${snapshot.data.version} (${snapshot.data.buildNumber})", style: TextStyle(
                              color: Get.theme.primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          onTap: () {

                          },
                        );
                      }else {
                        return Container();
                      }
                    },
                  )
                ],
              )
            )
          )
        )
      )
    );
  }
}