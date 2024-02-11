import 'package:flutter/material.dart';

class TextWidgetUI {
  static Text buildTextWidget(
      {required String title,
      required bool isBold,
      Color? color,
      required double fontSize,
      bool? isUnderlined,
      bool? isJustify}) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: color ?? Colors.black,
          fontSize: fontSize,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          fontFamily: "SF",
          decoration: isUnderlined != null
              ? TextDecoration.underline
              : TextDecoration.none,
          decorationColor: color ?? Colors.black),
    );
  }
}
