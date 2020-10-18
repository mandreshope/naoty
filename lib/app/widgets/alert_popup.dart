import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naoty/app/widgets/dialog_container.dart';
import 'package:naoty/app/widgets/primary_button.dart';

class AlertPopup extends StatelessWidget {
  final String title;
  final String content;
  final Function onCanceled;
  final bool isError;
  const AlertPopup({Key key,
    this.title,
    this.content,
    this.onCanceled,
    @required this.isError
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DialogContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Icon(isError ? Icons.error : Icons.check, color: Colors.red, size: 40,)
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Text(title.tr, style: TextStyle(
              fontSize: Get.textTheme.headline6.fontSize,
              fontWeight: FontWeight.bold,
              color: Get.context.theme.primaryColor
            ), textAlign: TextAlign.center,),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Text(content.tr, style: TextStyle(
              fontSize: Get.textTheme.subtitle1.fontSize,
              color: Get.context.theme.primaryColor
            ), textAlign: TextAlign.center,),
          ),
          SizedBox(height: 20,),
          PrimaryButton(
            height: 50,
            width: double.infinity,
            backgroundColor: Colors.white,
            borderColor: Colors.grey[200],
            child: Text("ANNULER".tr, style: TextStyle(
              color: Get.context.theme.primaryColor,
              fontSize: 18,
            ),),
            onPressed: onCanceled)
        ],
      ),
    );
  }
}