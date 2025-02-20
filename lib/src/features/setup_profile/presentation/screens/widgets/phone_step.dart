import 'package:chat_app/src/features/setup_profile/presentation/providers/setup_profile_provider.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.phoneController.addListener(_validateForm);
    });
  }

  _validateForm() {
    Future.delayed(Duration.zero, () {
      widget.completeStep(_formKey.currentState?.validate() == true);
    });
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
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
            Form(
              key: _formKey,
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return Strings.required;
                  }
                  if (provider.country.example.length != value.length) {
                    return Strings.validPhoneNumber;
                  }
                  return null;
                },
                maxLength: provider.country.example.length,
                controller: provider.phoneController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
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
                        onSelect: provider.changeCountry,
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          provider.country.phoneCode,
                          style: Theme.of(context).appBarTheme.titleTextStyle,
                        ),
                        const Icon(Icons.arrow_drop_down)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
