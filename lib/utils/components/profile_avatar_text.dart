import 'package:flutter/material.dart';

import '/helper/extension/context_extension.dart';

class ProfileAvatarText extends StatelessWidget {
  final String profileName;

  final double? fontSize;
  final Color? color;
  const ProfileAvatarText({
    required this.profileName,
    this.fontSize,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: color ?? context.dProvider.primaryColor,
      alignment: Alignment.center,
      child: Text(
        profileName.substring(0, 2).toUpperCase(),
        style: context.titleMedium?.copyWith(
            color: context.dProvider.whiteColor,
            fontSize: fontSize,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
