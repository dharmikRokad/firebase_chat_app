import 'package:chat_app/src/core/extensions/context_extensions.dart';
import 'package:chat_app/src/core/presentation/otp_verification_scren.dart';
import 'package:chat_app/src/features/setup_profile/presentation/providers/setup_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizard_stepper/wizard_stepper.dart';

class OtpStep extends StatefulWidget with WizardStep {
  OtpStep({super.key});

  @override
  State<OtpStep> createState() => _OtpStepState();
}

class _OtpStepState extends State<OtpStep> {
  final _formKey = GlobalKey<FormState>();

  final otpController = TextEditingController();

  late SetupProfileProvider provider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      otpController.addListener(_validateForm);
    });
  }

  _validateForm() {
    Future.delayed(Duration.zero, () async {
      if (_formKey.currentState?.validate() == true) {
        await provider.verifyOtp(
          otpController.text,
          onSuccess: (_) => widget.completeStep(true),
          onFailure: (val) {
            context.showError(val);
            widget.completeStep(false);
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<SetupProfileProvider>(context);
    return OtpVerificationScreen(
      phone: provider.fullPhone,
      bodyPadding: const EdgeInsets.only(left: 10),
      formKey: _formKey,
      otpController: otpController,
      onSendAgain: () => provider.sendOtp(),
    );
  }
}
