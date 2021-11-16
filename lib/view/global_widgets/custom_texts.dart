import 'package:flutter/material.dart';

class PrimaryText extends StatelessWidget {
  const PrimaryText(
    this.text, {
    Key? key,
    required this.fontSize,
    this.color = Colors.black,
    this.fontWeight = FontWeight.w400,
    this.lineHeight,
    this.textAlign,
    this.letterSpacing,
  }) : super(key: key);

  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final double? lineHeight;
  final TextAlign? textAlign;
  final double? letterSpacing;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontFamily: "Poppins",
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        height: lineHeight,
        letterSpacing: letterSpacing,
      ),
    );
  }
}
