import 'package:brain_wave_2/utils/colors.dart';
import 'package:flutter/material.dart';

abstract class CustomSnackBar {
  static void showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(
      content: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 18,
          color: AppColors.snackBarTextColor,
        ),
      ),
      action: SnackBarAction(
        label: 'Окей',
        onPressed: () {},
      ),
      backgroundColor: AppColors.snackBarBackgroundColor,
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}