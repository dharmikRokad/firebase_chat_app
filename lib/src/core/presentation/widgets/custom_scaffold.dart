import 'package:chat_app/src/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    super.key,
    required this.title,
    this.leading,
    this.actions,
    this.titleStyle,
    this.body,
  });

  final String title;
  final TextStyle? titleStyle;
  final Widget? leading;
  final List<Widget>? actions;
  final Widget? body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lDarkBg,
      appBar: AppBar(
        toolbarHeight: 100.h,
        leadingWidth: 62.w,
        leading: Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: leading,
        ),
        title: Text(
          title,
          style: titleStyle ??
              Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.white,
                    // fontWeight: FontWeight.bold,
                  ),
        ),
        actions: [
          ...(actions ?? []),
          20.w.horizontalSpace,
        ],
        centerTitle: true,
        backgroundColor: AppColors.transperent,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(40.r)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            10.h.verticalSpace,
            Container(
              height: 5.h,
              width: 30.w,
              decoration: BoxDecoration(
                color: AppColors.lLightGrey,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            10.h.verticalSpace,
            Expanded(child: body ?? const SizedBox.shrink())
          ],
        ),
      ),
    );
  }
}
