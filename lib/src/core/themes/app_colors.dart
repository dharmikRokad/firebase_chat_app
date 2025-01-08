import 'package:flutter/material.dart';

class AppColors {
  BuildContext context;

  AppColors._({required this.context});

  factory AppColors.of(BuildContext context) => AppColors._(context: context);

  static const Color lPrimary = Color(0xff24786D);
  static const Color lError = Color(0xffFF2D1B);

  static const lLightGrey = Color(0xffF3F6F6);
  static const lLightBlue = Color(0xffF2F7FB);

  static const Color lTextPrimary = Colors.black;
  static const Color lTextSecondary = Color(0xff797C7B);

  static const Color white = Color(0xffFFFFFF);
}
