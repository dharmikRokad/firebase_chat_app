import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    super.key,
    required this.url,
    this.radius,
    this.onTap,
  });

  final String url;
  final double? radius;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius ?? 26.r,
      backgroundImage: CachedNetworkImageProvider(url),
    );
  }
}
