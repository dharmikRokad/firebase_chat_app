import 'dart:developer';
import 'dart:io';

import 'package:chat_app/utils/img_picker_helper.dart';
import 'package:chat_app/utils/strings.dart';
import 'package:chat_app/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class SetUpProfileScreen extends StatefulWidget {
  const SetUpProfileScreen({super.key});

  @override
  State<SetUpProfileScreen> createState() => _SetUpProfileScreenState();
}

class _SetUpProfileScreenState extends State<SetUpProfileScreen> {
  final TextEditingController _fullNameController = TextEditingController();

  XFile? selectedImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
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
              _buildPhotoPickerWidget(),
              40.h.verticalSpace,
              TextFormField(
                controller: _fullNameController,
                onTapOutside: (_) => FocusScope.of(context).unfocus(),
                onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
                decoration: const InputDecoration(
                  labelText: Strings.fullName,
                  hintText: Strings.fullNAmeHint,
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value?.isEmpty == true || value == null) {
                    return Strings.emailRequired;
                  }
                  return null;
                },
              ),
              20.h.verticalSpace,
              AppButton(
                onPressed: _onSubmitTap,
                title: Strings.continueTxt,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onSubmitTap() {}

  Widget _buildPhotoPickerWidget() {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          height: 200.r,
          width: 200.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.shade300,
            image: selectedImage != null
                ? DecorationImage(
                    image: FileImage(File(selectedImage?.path ?? '')),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
        ),
        IconButton.filledTonal(
          icon: const Icon(Icons.add),
          onPressed: () async {
            selectedImage = await ImagePickweHelper().pickImage(context);
            log('image = ${selectedImage?.path}');
            if (selectedImage != null) setState(() {});
          },
        )
      ],
    );
  }
}
