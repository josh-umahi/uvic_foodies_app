import 'package:flutter/material.dart';

abstract class ColorConstants {
  static const lightGrey1 = Color(0xFFEEEEEF);
  static const lightGrey2 = Color(0xFFD4D4D4);
  static const darkGrey1 = Color(0xFF8E8E92);
  static const darkGrey2 = Color(0xFF363636);
  static const blue1 = Color(0xFF4172F0);
}

abstract class BorderConstants {
  static final primary = BorderRadius.circular(20);
  static const radius1 = 20.0;
}

abstract class SizedBoxes {
  static const vertical1 = SizedBox(height: 13);
}

final ourLogo = Image.asset(
  "assets/logo.png",
  height: 23,
);

void foobar(int x) {
  x = 9;
}
