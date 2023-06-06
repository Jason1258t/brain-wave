import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

class AppAnimations {
  static LoadingBouncingGrid bouncingSquare = LoadingBouncingGrid.square(
    backgroundColor: const Color(0xffFFFFFF),
    size: 80,
  );
  static LoadingBouncingLine bouncingLine = LoadingBouncingLine.circle(
    backgroundColor: const Color(0xffFFFFFF),
  );
  static LoadingBouncingLine bouncingLineChat = LoadingBouncingLine.circle(
    backgroundColor: const Color(0xff6C00C0),
  );
}
