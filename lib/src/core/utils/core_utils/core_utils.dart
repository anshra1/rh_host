import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rh_host/src/core/design_system/import.dart';

class CoreUtils {
  const CoreUtils._();

  static void showSnackBar(
    BuildContext context,
    String message,
  ) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColor.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(10),
        ),
      );
  }

  static void showLoadingDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  static Future<File?> pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      return File(image.path);
    }
    return null;
  }
}
