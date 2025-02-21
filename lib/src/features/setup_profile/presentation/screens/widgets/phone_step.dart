import 'package:chat_app/src/core/extensions/context_extensions.dart';
import 'package:chat_app/src/core/presentation/widgets/app_button.dart';
import 'package:chat_app/src/core/themes/app_colors.dart';
import 'package:chat_app/src/features/setup_profile/presentation/providers/setup_profile_provider.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:wizard_stepper/wizard_stepper.dart';

import '../../../../../core/strings.dart';

class PhoneStep extends StatefulWidget with WizardStep {
  PhoneStep({super.key});

  @override
  State<PhoneStep> createState() => _PhoneStepState();
}

class _PhoneStepState extends State<PhoneStep> {
  late SetupProfileProvider provider;

  /// TAG : OTP_Hold
  // ValueNotifier<bool> isSendOTPEnable = ValueNotifier(false);
  // ValueNotifier<bool> isOTPVisible = ValueNotifier(false);
  // final otpController = TextEditingController();
  // final FocusNode otpNode = FocusNode(debugLabel: 'otp_node');

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FocusNode phoneNode = FocusNode(debugLabel: 'phone_node');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.phoneController.addListener(_validateForm);
    });
  }

  _validateForm() {
    widget.completeStep(_formKey.currentState?.validate() == true);

    /// TAG : OTP_Hold
    // Future.delayed(Duration.zero, () {
    //   if (_formKey.currentState?.validate() == true) {
    //     isSendOTPEnable.value = true;
    //   } else {
    //     isSendOTPEnable.value = false;
    //     isOTPVisible.value = false;
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    return SizedBox(
      height: double.infinity,
      child: ListView(
        padding: const EdgeInsets.only(left: 20, top: 5),
        children: [
          5.verticalSpace,
          Text(
            Strings.phoneStepHeading,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.apply(fontWeightDelta: 2),
          ),
          10.verticalSpace,
          Text(
            Strings.phoneStepSubheading,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          30.verticalSpace,
          _buildPhoneInputField(),

          /// As Supabase otp verification is creating a new user
          /// The verify number functionality is `on Hold`.
          /// TAG : OTP_Hold

          // 10.verticalSpace,
          // ValueListenableBuilder(
          //   valueListenable: isSendOTPEnable,
          //   builder: (context, value, _) {
          //     return AppButton(
          //       onPressed: !value
          //           ? null
          //           : () async {
          //               await context.read<SetupProfileProvider>().sendOtp();
          //               isSendOTPEnable.value = false;
          //               isOTPVisible.value = true;
          //               if (!context.mounted) return;
          //               FocusScope.of(context).requestFocus(otpNode);
          //             },
          //       title: 'Send OTP',
          //     );
          //   },
          // ),
          // ValueListenableBuilder(
          //   valueListenable: isOTPVisible,
          //   builder: (context, value, _) {
          //     if (!value) return const SizedBox.shrink();

          //     return Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         20.verticalSpace,
          //         Text(
          //           "${Strings.enterCodeSentTo}\n${provider.fullPhone}",
          //           style: Theme.of(context).textTheme.bodyMedium,
          //         ),
          //         20.h.verticalSpace,
          //         Pinput(
          //           controller: otpController,
          //           focusNode: otpNode,
          //           onCompleted: (val) async {
          //             FocusScope.of(context).unfocus();
          //             await provider.verifyOtp(
          //               otpController.text,
          //               onSuccess: (_) => widget.completeStep(true),
          //               onFailure: (val) {
          //                 context.showError(val);
          //                 widget.completeStep(false);
          //               },
          //             );
          //           },
          //           defaultPinTheme: context.pinTheme,
          //           length: 6,
          //           hapticFeedbackType: HapticFeedbackType.mediumImpact,
          //           validator: (value) {
          //             if (value == null || value.length != 6) {
          //               return Strings.required;
          //             }
          //             return null;
          //           },
          //         ),
          //         20.verticalSpace,
          //         RichText(
          //           text: TextSpan(
          //             text: Strings.didntRecieveCode,
          //             style: Theme.of(context)
          //                 .textTheme
          //                 .bodySmall
          //                 ?.copyWith(color: AppColors.lPrimary),
          //             children: [
          //               TextSpan(
          //                 text: Strings.sendAgain,
          //                 recognizer: TapGestureRecognizer()
          //                   ..onTap = () => provider.sendOtp(),
          //                 style:
          //                     Theme.of(context).textTheme.bodySmall?.copyWith(
          //                           color: AppColors.lPrimary,
          //                           fontWeight: FontWeight.w600,
          //                         ),
          //               )
          //             ],
          //           ),
          //         ),
          //       ],
          //     );
          //   },
          // ),
        ],
      ),
    );
  }

  Widget _buildPhoneInputField() {
    return Form(
      key: _formKey,
      child: TextFormField(
        controller: provider.phoneController,
        focusNode: phoneNode,
        maxLength: provider.phoneCountry.example.length,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return Strings.required;
          }
          if (provider.phoneCountry.example.length != value.length) {
            return Strings.validPhoneNumber;
          }
          return null;
        },
        decoration: InputDecoration(
          filled: false,
          hintText: Strings.phoneNumber,
          border: const UnderlineInputBorder(),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: Color(0xFF908C95),
            ),
          ),
          prefixIcon: InkWell(
            onTap: () {
              showCountryPicker(
                context: context,
                countryListTheme: const CountryListThemeData(
                  bottomSheetHeight: 500,
                ),
                onSelect: provider.changePhoneCountry,
              );
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  provider.phoneCountry.phoneCode,
                  style: Theme.of(context).appBarTheme.titleTextStyle,
                ),
                const Icon(Icons.arrow_drop_down)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
