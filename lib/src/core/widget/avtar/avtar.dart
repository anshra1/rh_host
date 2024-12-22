import 'package:flutter/material.dart';
import 'package:rh_host/src/core/design_system/base/app_font.dart';
import 'package:rh_host/src/core/design_system/base/import.dart';

class AppAvatar extends StatelessWidget {
  const AppAvatar({
    this.imageUrl,
    this.name,
    this.size = 40,
    this.onTap,
    super.key,
  });

  final String? imageUrl;
  final String? name;
  final double size;
  final VoidCallback? onTap;

  String get initials {
    if (name == null) return '';
    final parts = name!.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name![0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    Widget avatar;
    if (imageUrl != null) {
      avatar = CircleAvatar(
        radius: size / 2,
        backgroundImage: NetworkImage(imageUrl!),
      );
    } else {
      avatar = CircleAvatar(
        radius: size / 2,
        backgroundColor: LightColorsToken.primaryLight,
        child: Text(
          initials,
          style: AppFonts.labelMedium.copyWith(
            color: LightColorsToken.textInverse,
          ),
        ),
      );
    }

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(size / 2),
        child: avatar,
      );
    }

    return avatar;
  }
}
