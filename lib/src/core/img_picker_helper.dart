import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickweHelper {
  final ImagePicker _picker = ImagePicker();

  static final ImagePickweHelper _instance = ImagePickweHelper._();

  factory ImagePickweHelper() => _instance;

  ImagePickweHelper._();

  Future<XFile?> pickImage(BuildContext context) async {
    return showModalBottomSheet<XFile?>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Pick image from',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.apply(fontWeightDelta: 2),
              ),
              30.h.verticalSpace,
              Row(
                children: [
                  // Camer option
                  InkWell(
                    onTap: () async {
                      return context.pop(await pickImageFromCamera());
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 40.r,
                          child: const Icon(CupertinoIcons.photo_camera),
                        ),
                        10.h.verticalSpace,
                        Text('Camera',
                            style: Theme.of(context).textTheme.bodyLarge),
                      ],
                    ),
                  ),
                  20.w.horizontalSpace,
                  // Gallery option
                  InkWell(
                    onTap: () async {
                      return context.pop(await pickImageFromGallery());
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 40.r,
                          child: const Icon(CupertinoIcons.photo),
                        ),
                        10.h.verticalSpace,
                        Text('Gallery',
                            style: Theme.of(context).textTheme.bodyLarge),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<XFile?> pickImageFromGallery() async {
    return await _picker.pickImage(source: ImageSource.gallery);
  }

  Future<XFile?> pickImageFromCamera() async {
    return await _picker.pickImage(source: ImageSource.camera);
  }
}
