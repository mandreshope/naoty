import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final double width;
  final int maxLines;
  final bool obscureText;
  final String labelText;
  final String hintText;
  final Color hintColor;
  final Color labelColor;
  final String errorText;
  final Widget suffixIcon;
  final Widget prefixIcon;
  final TextInputType keyboardType;
  final Color borderColor;
  final TextStyle style;
  final Function(String) onChanged;
  final List<TextInputFormatter> maskFormatter;
  InputField({Key key,
    @required this.controller,
    this.width,
    this.maxLines,
    this.hintColor,
    this.labelColor,
    this.obscureText,
    this.labelText,
    final this.hintText,
    this.errorText,
    this.suffixIcon,
    this.prefixIcon,
    this.keyboardType,
    this.borderColor,
    this.onChanged,
    this.style,
    this.maskFormatter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0),
      padding: EdgeInsets.only(bottom: 5, top: 10),
      width: width ?? double.infinity,
      child: TextField(
        controller: controller,
        maxLines: maxLines ?? 1,
        minLines: 1,
        keyboardType: keyboardType ?? TextInputType.text,
        obscureText: obscureText ?? false,
        style: style ?? TextStyle(fontSize: 18),
        onChanged: onChanged,
        inputFormatters: maskFormatter,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 20),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          labelText: labelText,
          hintText: hintText,
          hintStyle: TextStyle(color: hintColor ?? Get.theme.primaryColor.withOpacity(0.5), fontSize: 16),
          labelStyle: TextStyle(color: labelColor ?? Get.theme.primaryColor.withOpacity(0.5), fontSize: 16),
          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(
            color: borderColor ?? Colors.grey[200]
          )),
          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(
            color: borderColor ?? Colors.grey[200]
          )),
          errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: borderColor ?? Colors.grey[200])),
          errorText: errorText,
        ),
      )
    );
  }
}