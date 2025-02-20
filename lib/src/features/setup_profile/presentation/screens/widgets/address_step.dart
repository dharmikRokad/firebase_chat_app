import 'package:chat_app/src/core/strings.dart';
import 'package:chat_app/src/features/setup_profile/presentation/providers/setup_profile_provider.dart';
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

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<SetupProfileProvider>(context, listen: true);

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            TextFormField(
              controller: provider.addressController,
              focusNode: _addressNode,
              decoration: const InputDecoration(
                labelText: Strings.address,
                // hintText: 'Enter your address',
                border: OutlineInputBorder(),
              ),
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
            DropdownButtonFormField<String>(
              value: provider.city,
              focusNode: _cityNode,
              items: [
                'Surat',
                'Ahemdabad',
                'Mumbai',
                'Vadodara',
                'Rajkot',
                'Pune',
                'Anand'
              ]
                  .map(
                    (e) => DropdownMenuItem(
                      value: e.toLowerCase(),
                      child: Text(e),
                    ),
                  )
                  .toList(),
              onChanged: (val) {
                provider.changeCity(val);
                _validateForm();
                FocusScope.of(context).requestFocus(_stateNode);
              },
              decoration: const InputDecoration(
                labelText: Strings.city,
                // hintText: 'Select your city',
                border: OutlineInputBorder(),
              ),
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return Strings.required;
                }
                return null;
              },
            ),
            20.verticalSpace,
            DropdownButtonFormField<String>(
              value: provider.state,
              focusNode: _stateNode,
              items: ['Gujrat', 'Maharashtra', 'Madhya Pradesh', 'Rajasthan']
                  .map(
                    (e) => DropdownMenuItem(
                      value: e.toLowerCase(),
                      child: Text(e),
                    ),
                  )
                  .toList(),
              onChanged: (val) {
                provider.changeState(val);
                _validateForm();
                FocusScope.of(context).requestFocus(_pincodeNode);
              },
              decoration: const InputDecoration(
                labelText: Strings.state,
                // hintText: 'Select your state',
                border: OutlineInputBorder(),
              ),
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
