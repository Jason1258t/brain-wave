import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

abstract class AppColors {
  static const purpleButton = Color(0xff4A09B5);
  static const lightBlueText = Color(0xffE1D7FF);
  static const lightGrayText = Color(0xffB0B0B0);
  static const background = Color(0xff131124);
  static const widgetsBackground = Color(0xff272850);
  static const snackBarBackgroundColor = Color(0xff272850);
  static const snackBarTextColor = Color(0xffE1D7FF);
  static const red = Colors.red;
  static const checkIcon = Color(0xff00D1FF);
  static const appBarChat = Color(0xff292B57);
  static const backgroundChat = Color(0xff131124);
  static const chatYour = Color(0xff454682);
}

const colors = [
  Color(0xffff6767),
  Color(0xff66e0da),
  Color(0xfff5a2d9),
  Color(0xfff0c722),
  Color(0xff6a85e5),
  Color(0xfffd9a6f),
  Color(0xff92db6e),
  Color(0xff73b8e5),
  Color(0xfffd7590),
  Color(0xffc78ae5),
];

Color getUserAvatarNameColor(types.User user) {
  final index = user.id.hashCode % colors.length;
  return colors[index];
}