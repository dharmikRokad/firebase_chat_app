import 'package:chat_app/src/core/extensions/context_extensions.dart';
import 'package:chat_app/src/core/extensions/object_extensions.dart';
import 'package:chat_app/src/core/strings.dart';
import 'package:chat_app/src/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({
    super.key,
    required this.phone,
    required this.formKey,
    required this.otpController,
    this.bodyPadding,
    this.appbar,
    this.onSendAgain,
  });

  final String phone;
  final GlobalKey<FormState> formKey;
  final TextEditingController otpController;
  final EdgeInsetsGeometry? bodyPadding;
  final PreferredSizeWidget? appbar;
  final VoidCallback? onSendAgain;

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appbar,
      body: SafeArea(
        child: Padding(
          padding: widget.bodyPadding ?? EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Strings.enterCodeSentTo,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.apply(fontWeightDelta: 2),
              ),
              10.h.verticalSpace,
              Text(
                widget.phone,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              20.h.verticalSpace,
              Form(
                  key: widget.formKey,
                  child: Pinput(
                    controller: widget.otpController,
                    onCompleted: log,
                    defaultPinTheme: context.pinTheme,
                    length: 6,
                    hapticFeedbackType: HapticFeedbackType.mediumImpact,
                    validator: (value) {
                      if (value == null || value.length != 6) {
                        return Strings.required;
                      }
                      return null;
                    },
                  )),
              20.verticalSpace,
              Row(
                children: [
                  Text(
                    Strings.didntRecieveCode,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: AppColors.lPrimary),
                  ),
                  8.horizontalSpace,
                  InkWell(
                    onTap: widget.onSendAgain,
                    child: Text(
                      Strings.sendAgain,
                      style: TextStyle(
                        color: AppColors.lPrimary,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
