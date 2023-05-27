import 'package:brain_wave_2/utils/fonts.dart';
import 'package:flutter/material.dart';

class CustomFilledTextField extends StatelessWidget {
  final double width;
  final double height;
  final String hintText;
  final TextEditingController controller;

  CustomFilledTextField(
      {Key? key,
      this.width = 290,
      this.height = 50,
      required this.hintText,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(7)),
          boxShadow: [
            BoxShadow(
              color: Color(0xff7058FF),
              blurRadius: 7,
              //spreadRadius: 15,
              offset: Offset(0, 0),
            )
          ]),
      width: width,
      height: height,
      child: TextFormField(
        style: AppTypography.font16lightGray,
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xff323465),
          hintText: hintText,
          hintStyle: AppTypography.font16lightGray,
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(13)),
            borderSide: BorderSide(
              color: Color(0xff9687D3),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(13)),
            borderSide: BorderSide(
              color: Color(0xff9687D3),
            ),
          ),
        ),
        controller: controller,
      ),
    );
  }
}
