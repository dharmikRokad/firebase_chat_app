import 'package:chat_app/src/core/extensions/date_time_extension.dart';
import 'package:chat_app/src/core/strings.dart';
import 'package:chat_app/src/features/setup_profile/presentation/providers/setup_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wizard_stepper/wizard_stepper.dart';

class PersonalInfoStep extends StatefulWidget with WizardStep {
  PersonalInfoStep({super.key});

  @override
  State<PersonalInfoStep> createState() => _PersonalInfoStepState();
}

class _PersonalInfoStepState extends State<PersonalInfoStep> {
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: 'address_form');

  final FocusNode _fNameNode = FocusNode(debugLabel: '_fnameNode');
  final FocusNode _lNameNode = FocusNode(debugLabel: '_lnameNode');
  final FocusNode _proffessionNode = FocusNode(debugLabel: '_professionNode');
  final FocusNode _usernameNode = FocusNode(debugLabel: '_usernameNode');

  late SetupProfileProvider provider;

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.fnameController.addListener(_validateForm);
      provider.lNameController.addListener(_validateForm);
      provider.usernameController.addListener(_validateForm);
      provider.proffesionController.addListener(_validateForm);
      provider.dobController.addListener(_validateForm);
    });
  }

  _validateForm() {
    Future.delayed(Duration.zero, () {
      widget.completeStep(_formKey.currentState?.validate() == true &&
          provider.gender != null &&
          provider.dob != null);
    });
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<SetupProfileProvider>(context);
    return Form(
      key: _formKey,
      child: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        shrinkWrap: true,
        padding: const EdgeInsets.only(left: 10),
        children: [
          5.verticalSpace,
          Text(
            Strings.setupProfile,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.apply(fontWeightDelta: 2),
          ),
          10.h.verticalSpace,
          Text(
            Strings.personalInfoStepSubheading,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          40.h.verticalSpace,
          _buildInputNameWidget(),
          20.h.verticalSpace,
          _buildInputUsernameWidget(),
          20.h.verticalSpace,
          _buildInputProfessionWidget(),
          20.h.verticalSpace,
          _buildGenderSelectionWidget(),
          20.h.verticalSpace,
          _buildBirthDateSelectionwidget(),
          30.h.verticalSpace,
        ],
      ),
    );
  }

  Widget _buildInputNameWidget() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: provider.fnameController,
            focusNode: _fNameNode,
            onTapOutside: (_) => FocusScope.of(context).unfocus(),
            onFieldSubmitted: (_) =>
                FocusScope.of(context).requestFocus(_lNameNode),
            decoration: const InputDecoration(
              labelText: Strings.fName,
              hintText: Strings.fNameHint,
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value?.isEmpty == true || value == null) {
                return Strings.required;
              }
              return null;
            },
          ),
        ),
        10.w.horizontalSpace,
        Expanded(
          child: TextFormField(
            controller: provider.lNameController,
            focusNode: _lNameNode,
            onTapOutside: (_) => FocusScope.of(context).unfocus(),
            onFieldSubmitted: (_) =>
                FocusScope.of(context).requestFocus(_usernameNode),
            decoration: const InputDecoration(
              labelText: Strings.lName,
              hintText: Strings.lNmaeHint,
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value?.isEmpty == true || value == null) {
                return Strings.required;
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildInputUsernameWidget() {
    return TextFormField(
      controller: provider.usernameController,
      focusNode: _usernameNode,
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      onFieldSubmitted: (_) =>
          FocusScope.of(context).requestFocus(_proffessionNode),
      decoration: const InputDecoration(
        labelText: Strings.username,
        prefixText: '@',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value?.isEmpty == true || value == null) {
          return Strings.required;
        }
        return null;
      },
    );
  }

  Widget _buildInputProfessionWidget() {
    return TextFormField(
      controller: provider.proffesionController,
      focusNode: _proffessionNode,
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
      decoration: const InputDecoration(
        labelText: Strings.proffesion,
        hintText: Strings.proffesionHint,
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value?.isEmpty == true || value == null) {
          return Strings.required;
        }
        return null;
      },
    );
  }

  Widget _buildGenderSelectionWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Strings.gender,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.apply(fontWeightDelta: 1, fontSizeDelta: 1),
        ),
        10.h.verticalSpace,
        Row(
          children: [
            Expanded(
              child: _buildGenderContainer(Strings.male),
            ),
            10.w.horizontalSpace,
            Expanded(
              child: _buildGenderContainer(Strings.female),
            ),
            10.w.horizontalSpace,
            Expanded(
              child: _buildGenderContainer(Strings.other),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGenderContainer(String text) {
    return InkWell(
      onTap: () {
        if (provider.gender == text) {
          provider.setGender(null);
        } else {
          provider.setGender(text);
        }
        _validateForm();
      },
      child: AnimatedContainer(
        height: 50.h,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 450),
        decoration: BoxDecoration(
          color: provider.gender == text
              ? Theme.of(context).colorScheme.primary
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: provider.gender == text
                ? Colors.transparent
                : Theme.of(context).primaryColor,
          ),
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyLarge?.apply(
                color: provider.gender == text ? Colors.white : Colors.black,
              ),
        ),
      ),
    );
  }

  Widget _buildBirthDateSelectionwidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          Strings.dateOfBirth,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.apply(fontWeightDelta: 1, fontSizeDelta: 1),
        ),
        10.h.verticalSpace,
        TextFormField(
          controller: provider.dobController,
          readOnly: true,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: Strings.dobHint,
            suffixIcon: IconButton(
              onPressed: () {
                if (provider.dob != null) {
                  provider.setDob(null);
                  provider.dobController.text = '';
                } else {
                  openDatePicker().then(
                    (value) {
                      if (value != null) {
                        provider.setDob(value);
                        provider.dobController.text = value.ddMonYYYY;
                        if (!mounted) return;
                        FocusScope.of(context).unfocus();
                      }
                    },
                  );
                }
              },
              icon: Icon(
                  provider.dob == null ? Icons.calendar_month : Icons.clear),
            ),
          ),
          onTapOutside: (_) => FocusScope.of(context).unfocus(),
          onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
          validator: (value) {
            if (value?.isEmpty == true || value == null) {
              return Strings.required;
            }
            return null;
          },
        ),
      ],
    );
  }

  Future<DateTime?> openDatePicker() async {
    return showDatePicker(
      context: context,
      firstDate: DateTime(1947),
      lastDate: DateTime.now(),
    );
  }
}
