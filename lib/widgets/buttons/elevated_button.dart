import 'package:brain_wave_2/utils/fonts.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback callback;
  final String text;
  final double width;
  final double height;
  final TextStyle styleText;

  const CustomElevatedButton(
      {Key? key,
      required this.callback,
      required this.text,
      this.styleText = AppTypography.font20fff,
      this.width = 290,
      this.height = 50,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(14))),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff4A09B5),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(14)))),
        onPressed: callback,
        child: Text(
          text,
          style: styleText,
        ),
      ),
    );
  }
}
