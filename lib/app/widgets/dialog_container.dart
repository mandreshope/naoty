import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogContainer extends StatelessWidget {
  final Widget? child;
  const DialogContainer({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: Get.width*.9),
        child: Material(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 0,
          type: MaterialType.card,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
            child: child
          )
        ),
      ),
    );
  }
}