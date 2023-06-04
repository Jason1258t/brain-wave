import 'package:brain_wave_2/utils/colors.dart';
import 'package:brain_wave_2/utils/fonts.dart';
import 'package:flutter/material.dart';

class CustomPasswordField extends StatefulWidget {
  final double width;
  final double height;
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyBoardType;
  final bool obscureText;
  final bool isError;

  CustomPasswordField({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.isError,
    this.width = 290,
    this.height = 50,
    this.obscureText = false,
    this.keyBoardType = TextInputType.text,
  }) : super(key: key);

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool hideText = true;

  void showHide() {
    setState(() {
      hideText = !hideText;
    });
  }

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
      width: widget.width,
      height: widget.height,
      child: TextFormField(
        style: AppTypography.font16lightGray,
        decoration: InputDecoration(
          suffixIcon: GestureDetector(
            onTap: showHide,
            child: Icon(
              hideText ? Icons.remove_red_eye_outlined : Icons.remove_red_eye,
            ),
          ),
          filled: true,
          fillColor: const Color(0xff323465),
          hintText: widget.hintText,
          hintStyle: AppTypography.font16lightGray,
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(13)),
            borderSide: BorderSide(
                color: widget.isError ? const Color(0xff9687D3) : const Color(
                    0xffE01748),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(13)),
            borderSide: BorderSide(
                color: widget.isError ? const Color(0xff9687D3) : const Color(
                    0xffE01748),
            ),
          ),
        ),
        controller: widget.controller,
        obscureText: hideText,
      ),
    );
  }
}
