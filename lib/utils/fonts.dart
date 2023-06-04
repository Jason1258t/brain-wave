import 'package:brain_wave_2/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class AppTypography {
  static const font32fff = TextStyle(
      color: Colors.white,
      fontSize: 32,
      shadows: [
        Shadow(
          offset: Offset(0, 2),
          blurRadius: 20.0,
          color: Color(0xff0085FF),
        ),
      ]);

  static const font20fff = TextStyle(fontSize: 20, color: Colors.white);

  static const font204F6BFF = TextStyle(color: Color(0xff4F6BFF), fontSize: 20);

  static const font16lightGray = TextStyle(color: AppColors.lightGrayText);

  static const font24lightBlue = TextStyle(color: AppColors.lightBlueText, fontSize: 24);

  static const font18lightBlue = TextStyle(color: AppColors.lightBlueText, fontSize: 18);

  static const font16white = TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400);

  static const font20white = TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500);

  static const font14milk = TextStyle(color: Color(0xffC1C1C1), fontSize: 16, fontWeight: FontWeight.w400);
}
