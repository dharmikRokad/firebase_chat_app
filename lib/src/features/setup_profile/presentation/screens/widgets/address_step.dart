import 'package:chat_app/src/core/strings.dart';
import 'package:chat_app/src/features/setup_profile/presentation/providers/setup_profile_provider.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wizard_stepper/wizard_stepper.dart';

class AddressStep extends StatefulWidget with WizardStep {
  AddressStep({super.key});

  @override
  State<AddressStep> createState() => _AddressStepState();
}

class _AddressStepState extends State<AddressStep> {
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: 'address_form');

  final FocusNode _addressNode = FocusNode(debugLabel: 'address_node');

  final FocusNode _cityNode = FocusNode(debugLabel: 'city_node');

  final FocusNode _stateNode = FocusNode(debugLabel: 'state_node');

  final FocusNode _pincodeNode = FocusNode(debugLabel: 'pincode_node');

  late SetupProfileProvider provider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      provider.addressController.addListener(_validateForm);
      provider.pinController.addListener(_validateForm);
    });
  }

  @override
  void dispose() {
    _addressNode.dispose();
    _cityNode.dispose();
    _stateNode.dispose();
    _pincodeNode.dispose();
    super.dispose();
  }

  void _validateForm() {
    Future.delayed(Duration.zero, () {
      widget.completeStep(_formKey.currentState?.validate() == true);
    });
  }

  String? dropdownValidator(String? val) {
    if (val == null || val.isEmpty) {
      return Strings.required;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<SetupProfileProvider>(context, listen: true);

    return SizedBox(
      height: double.infinity,
      child: Form(
        key: _formKey,
        child: ListView(
        padding: const EdgeInsets.only(left: 10, top: 5),
          children: [
            Text(
              Strings.addressStepHeading,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            10.verticalSpace,
            Text(
              Strings.addressStepSubheading,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            30.verticalSpace,
            SelectState(
              onCountryChanged: (val) {
                _validateForm();
                provider.changeCountry(val);
              },
              onStateChanged: (val) {
                _validateForm();
                provider.changeState(val);
              },
              onCityChanged: (val) {
                _validateForm();
                provider.changeCity(val);
              },
              spacing: 20,
              countryValidator: dropdownValidator,
              stateValidator: dropdownValidator,
              cityValidator: dropdownValidator,
            ),
            20.verticalSpace,
            TextFormField(
              controller: provider.addressController,
              focusNode: _addressNode,
              decoration: const InputDecoration(
                labelText: Strings.address,
                border: OutlineInputBorder(),
              ),
              minLines: 1,
              maxLines: 2,
              onTapOutside: (_) => FocusScope.of(context).unfocus(),
              onFieldSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(_cityNode),
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return Strings.required;
                }
                return null;
              },
            ),
            20.verticalSpace,
            TextFormField(
              controller: provider.pinController,
              focusNode: _pincodeNode,
              inputFormatters: [
                LengthLimitingTextInputFormatter(6),
                FilteringTextInputFormatter.digitsOnly,
              ],
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: Strings.pincode,
                // hintText: 'Enter your pincode',
                border: OutlineInputBorder(),
              ),
              onTapOutside: (_) => FocusScope.of(context).unfocus(),
              onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return Strings.required;
                }
        
                if (val.length < 6) {
                  return Strings.validPincode;
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
