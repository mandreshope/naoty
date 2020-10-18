import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrimaryButton extends StatelessWidget {
  final Widget child;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final borderColor;
  final Color backgroundColor;
  final Color shadowColor;
  final double elevation;
  final double height;
  final double width;
  final Function onPressed;
  final double radius;
  const PrimaryButton({Key key, 
  @required this.child, 
  @required this.onPressed, 
  this.margin,
  this.padding,
  this.borderColor,
  this.backgroundColor,
  this.shadowColor,
  this.elevation,
  this.height,
  this.width,
  this.radius
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 60,
      width: width ?? double.infinity,
      margin: margin ?? EdgeInsets.all(0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            blurRadius: elevation ?? 0,
            offset: Offset(0, elevation ?? 0),
            color: shadowColor ?? Get.context.theme.primaryColor.withOpacity(0.20)
          )
        ]
      ),
      child: FlatButton(
        padding: padding ?? EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius??30),
          side: BorderSide(color: borderColor ?? Colors.transparent)
        ),
        color: backgroundColor ?? Colors.white,
        child: child,
        onPressed: onPressed
      ),
    );
  }
}