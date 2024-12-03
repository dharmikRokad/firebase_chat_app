import 'dart:io';

import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/utils/constants.dart';
import 'package:chat_app/utils/extensions/context_extensions.dart';
import 'package:chat_app/utils/extensions/date_time_extension.dart';
import 'package:chat_app/utils/extensions/object_extensions.dart';
import 'package:chat_app/utils/img_picker_helper.dart';
import 'package:chat_app/utils/routes/app_routes.dart';
import 'package:chat_app/utils/strings.dart';
import 'package:chat_app/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SetUpProfileScreen extends StatefulWidget {
  const SetUpProfileScreen({super.key});

  @override
  State<SetUpProfileScreen> createState() => _SetUpProfileScreenState();
}

class _SetUpProfileScreenState extends State<SetUpProfileScreen> {
  final GlobalKey<FormState> _fromKey =
      GlobalKey<FormState>(debugLabel: 'profile_form');

  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _lNameController = TextEditingController();
  final TextEditingController _proffesionController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  final FocusNode _fNameNode = FocusNode(debugLabel: '_fnameNode');
  final FocusNode _lNameNode = FocusNode(debugLabel: '_lnameNode');
  final FocusNode _proffessionNode = FocusNode(debugLabel: '_professionNode');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child:
              Consumer<AuthenticationProvider>(builder: (context, provider, _) {
            return SingleChildScrollView(
              child: Form(
                key: _fromKey,
                child: Column(
                  children: [
                    Text(
                      Strings.setupProfile,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.apply(fontWeightDelta: 2),
                    ),
                    20.h.verticalSpace,
                    _buildPhotoPickerWidget(provider),
                    40.h.verticalSpace,
                    _buildInputNameWidget(),
                    20.h.verticalSpace,
                    _buildInputProfessionWidget(),
                    20.h.verticalSpace,
                    _buildGenderSelectionWidget(provider),
                    20.h.verticalSpace,
                    _buildBirthDateSelectionwidget(provider),
                    30.h.verticalSpace,
                    AppButton(
                      onPressed: _onSubmitTap,
                      title: Strings.continueTxt,
                      isLoading: provider.isLaoding,
                    )
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  void _onSubmitTap() async {
    final provider = context.read<AuthenticationProvider>();

    if (provider.profilePic == null) {
      context.showWarning('Profile pic is required.');
      return;
    }

    if (_fromKey.currentState?.validate() == true) {
      if (provider.gender == null) {
        context.showWarning('Select appropriate gender.');
        return;
      }

      final profilePicUrl = await provider.uploadProfilePick(
        onFailure: (msg) {
          context.showError(msg);
        },
      );

      if (profilePicUrl == null) return;
      await provider.updateProfile(
        {
          Consts.kFNameKey: _fnameController.text,
          Consts.kLNameKey: _lNameController.text,
          Consts.kProfessionKey: _proffesionController.text,
          Consts.kBirthDateKey: _dobController.text,
          Consts.kGenderKey: provider.gender,
          Consts.kProfilePicKey: profilePicUrl,
        },
        onSuccess: (msg) {
          context.showSuccess(msg);
          context.pushReplacementNamed(AppRoutes.profileCompleted.name);
        },
        onFailure: (msg) => context.showError(msg),
      );
    }
  }

  Widget _buildPhotoPickerWidget(AuthenticationProvider provider) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          height: 180.r,
          width: 180.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.shade300,
            image: provider.profilePic != null
                ? DecorationImage(
                    image: FileImage(File(provider.profilePic?.path ?? '')),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
        ),
        IconButton.filledTonal(
          icon: Icon(provider.profilePic == null ? Icons.add : Icons.clear),
          onPressed: () async {
            if (provider.profilePic != null) {
              provider.setProfilePic(null);
              return;
            }
            provider
                .setProfilePic(await ImagePickweHelper().pickImage(context));
            this.log('image = ${provider.profilePic?.path}');
          },
        )
      ],
    );
  }

  Widget _buildInputNameWidget() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _fnameController,
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
            controller: _lNameController,
            focusNode: _lNameNode,
            onTapOutside: (_) => FocusScope.of(context).unfocus(),
            onFieldSubmitted: (_) =>
                FocusScope.of(context).requestFocus(_proffessionNode),
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

  Widget _buildInputProfessionWidget() {
    return TextFormField(
      controller: _proffesionController,
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

  Widget _buildGenderSelectionWidget(AuthenticationProvider provider) {
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
              child: _buildGenderContainer(Strings.male, provider),
            ),
            10.w.horizontalSpace,
            Expanded(
              child: _buildGenderContainer(Strings.female, provider),
            ),
            10.w.horizontalSpace,
            Expanded(
              child: _buildGenderContainer(Strings.other, provider),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGenderContainer(String text, AuthenticationProvider provider) {
    return InkWell(
      onTap: () {
        if (provider.gender == text) {
          provider.setGender(null);
        } else {
          provider.setGender(text);
        }
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

  Widget _buildBirthDateSelectionwidget(AuthenticationProvider provider) {
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
          controller: _dobController,
          readOnly: true,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: Strings.dobHint,
            suffixIcon: IconButton(
              onPressed: () {
                if (provider.dob != null) {
                  provider.setDob(null);
                  _dobController.text = '';
                } else {
                  openDatePicker().then(
                    (value) {
                      if (value != null) {
                        provider.setDob(value);
                        _dobController.text = value.ddMonYYYY;
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
          onFieldSubmitted: (_) => _onSubmitTap,
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
