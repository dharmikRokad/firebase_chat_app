import 'package:chat_app/src/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.iconPath,
    this.onPressed,
  });

  final String iconPath;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: const Size.fromRadius(26),
      child: IconButton.outlined(
        onPressed: onPressed,
        icon: Image.asset(
          iconPath,
          height: 20,
          width: 20,
          color: AppColors.white,
        ),
        style: IconButton.styleFrom(
          fixedSize: const Size.fromRadius(15),
          shape: const CircleBorder(),
          side: const BorderSide(
            color: AppColors.lBorder,
            width: 1,
          ),
        ),
      ),
    );
  }
}
