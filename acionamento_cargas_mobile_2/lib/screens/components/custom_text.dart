import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  CustomText(
      {this.corText,
      this.text,
      this.fontSize,
      this.fontWeight,
      this.textAlign,
      this.textDecoration});

  final Color corText;
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final TextDecoration textDecoration;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: corText,
        fontSize: fontSize,
        fontWeight: fontWeight,
        decoration: textDecoration,
      ),
      overflow: TextOverflow.ellipsis,
    );
  }
}
