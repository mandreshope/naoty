import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingDialog extends StatelessWidget {
  final Color color;
  const LoadingDialog({Key key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(color??Get.context.theme.primaryColor),),),
    );
  }
}