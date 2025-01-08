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
    this.isLoading = false,
  });

  final VoidCallback? onPressed;
  final String title;
  final Widget? prefix;
  final Widget? suffix;
  final int prefixSpace;
  final int suffixSpace;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: Size(85.sw, 50.h),
        backgroundColor: isLoading
            ? Theme.of(context).colorScheme.surface
            : Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      child: isLoading
          ? SizedBox(
              height: 30.r,
              width: 30.r,
              child: CircularProgressIndicator(
                strokeCap: StrokeCap.round,
                strokeWidth: 3,
                color: Theme.of(context).colorScheme.primary,
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
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
                      color: Theme.of(context).colorScheme.surface),
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
