import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.prefix,
    this.suffix,
    this.prefixSpace = 20,
    this.suffixSpace = 20,
  });

  final VoidCallback onPressed;
  final String title;
  final Widget? prefix;
  final Widget? suffix;
  final int prefixSpace;
  final int suffixSpace;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: Size(85.sw, 45.h),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          10.h.horizontalSpace,
          if (prefix != null) ...[
            prefix!,
            prefixSpace.h.horizontalSpace,
          ],
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.apply(
                fontWeightDelta: 2,
                color: Theme.of(context).colorScheme.onSurface),
          ),
          if (suffix != null) ...[
            suffixSpace.h.horizontalSpace,
            suffix!,
          ],
          10.h.horizontalSpace,
        ],
      ),
    );
  }
}
