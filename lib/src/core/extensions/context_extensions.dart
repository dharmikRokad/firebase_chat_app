import 'package:chat_app/src/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

extension ThemeExtensions on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
  ThemeData get theme => Theme.of(this);

  AppColors get appColors => AppColors.of(this);
}

extension SnackBarExt on BuildContext {
  showSuccess(String msg) {
    final SnackBar snak = SnackBar(
      content: Text(msg),
      showCloseIcon: true,
      backgroundColor: Colors.green,
    );
    return ScaffoldMessenger.of(this).showSnackBar(snak);
  }

  showError(String msg) {
    final SnackBar snak = SnackBar(
      content: Text(msg),
      showCloseIcon: true,
      backgroundColor: Colors.red,
    );
    return ScaffoldMessenger.of(this).showSnackBar(snak);
  }

  showWarning(String msg) {
    final SnackBar snak = SnackBar(
      content: Text(msg),
      showCloseIcon: true,
      backgroundColor: Colors.orange,
    );
    return ScaffoldMessenger.of(this).showSnackBar(snak);
  }

  PinTheme get pinTheme => PinTheme(
        width: 56,
        height: 56,
        textStyle: TextStyle(
          fontSize: 28.sp,
          fontWeight: FontWeight.w600,
        ),
        decoration: BoxDecoration(
          color: Theme.of(this).brightness == Brightness.dark
              ? AppColors.lTextSecondary
              : AppColors.lLightGrey,
          borderRadius: BorderRadius.circular(4),
        ),
      );
}
