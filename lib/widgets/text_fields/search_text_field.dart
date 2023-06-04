import 'package:brain_wave_2/utils/colors.dart';
import 'package:brain_wave_2/utils/fonts.dart';
import 'package:flutter/material.dart';

class CustomSearchField extends StatelessWidget {
  final double width;
  final double height;
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyBoardType;
  final bool obscureText;
  final void Function(String?) callback;

  CustomSearchField(
      {Key? key,
      this.width = 290,
      this.height = 45,
      required this.hintText,
      required this.controller,
      required this.callback,
      this.obscureText = false,
      this.keyBoardType = TextInputType.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(7)),
      ),
      width: width,
      height: height,
      child: TextFormField(
        style: AppTypography.font16lightGray,
        onSaved: callback,
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.search,
            color: AppColors.lightGrayText,
            size: 20,
          ),
          enabledBorder: const OutlineInputBorder(borderSide: BorderSide(width: 0)),
          focusedBorder: const OutlineInputBorder(borderSide: BorderSide(width: 0)),
          filled: true,
          fillColor: const Color(0xff323465),
          hintText: hintText,
          hintStyle: AppTypography.font16lightGray,
        ),
        controller: controller,
      ),
    );
  }
}
