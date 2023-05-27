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

  static const font16lightGray = TextStyle(color: Color(0xffB0B0B0));
}
