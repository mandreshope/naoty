import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naoty/app/modules/about/about_controller.dart';
import 'package:package_info/package_info.dart';

class AboutView extends GetView<AboutController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('A propos'),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: FutureBuilder(
            future: PackageInfo.fromPlatform(),
            builder: (context, AsyncSnapshot snapshot) {
              if(snapshot.hasData) {
                return Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.apps_outlined, color: Get.theme.primaryColor),
                      title: Text("appName : ${snapshot.data.appName })", style: TextStyle(
                          color: Get.theme.primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.update, color: Get.theme.primaryColor),
                      title: Text("version : ${snapshot.data.version})", style: TextStyle(
                          color: Get.theme.primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.build, color: Get.theme.primaryColor),
                      title: Text("buildNumber : (${snapshot.data.buildNumber})", style: TextStyle(
                          color: Get.theme.primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.code, color: Get.theme.primaryColor),
                      title: Text("developed by mandreshope", style: TextStyle(
                          color: Get.theme.primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                  ],
                );
              }else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}