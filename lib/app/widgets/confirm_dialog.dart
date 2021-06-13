import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naoty/app/widgets/primary_button.dart';

import 'dialog_container.dart';

class ConfirmDialog extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final String? content;
  final Function? onAccepted;
  final Function? onCanceled;
  const ConfirmDialog(
      {Key? key,
      this.title,
      this.subTitle,
      this.content,
      this.onAccepted,
      this.onCanceled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DialogContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              title!.tr,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Get.context!.theme.primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          subTitle != null
              ? Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    subTitle!.tr,
                    style: TextStyle(
                      fontSize: Get.textTheme.headline6!.fontSize,
                      fontWeight: FontWeight.bold,
                      color: Get.context!.theme.primaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              : Container(),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              content!.tr,
              style: TextStyle(
                fontSize: Get.textTheme.subtitle1!.fontSize,
                color: Get.context!.theme.primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: PrimaryButton(
                  height: 50,
                  backgroundColor:
                      Get.context!.theme.primaryColor.withOpacity(0.7),
                  child: Text(
                    "OUI".tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  onPressed: onAccepted,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: PrimaryButton(
                  height: 50,
                  backgroundColor: Get.context!.theme.primaryColor,
                  child: Text(
                    "NON".tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  onPressed: onCanceled,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
