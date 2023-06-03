import 'package:flutter/material.dart';

class IconTextButton extends StatelessWidget {
  const IconTextButton(
      {Key? key,
        required this.title,
        required this.onPressed,
        required this.icon,
        this.height = 70,
        this.width = 320,
        this.padding = const EdgeInsets.all(10),
        this.borderRadius = 5,
        this.color = const Color(0xff4A09B5)})
      : super(key: key);

  final String title;
  final VoidCallback onPressed;
  final double height;
  final double width;
  final EdgeInsets padding;
  final double borderRadius;
  final Color color;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 8,),
            Text(title, style: const TextStyle(color: Colors.white, fontSize: 18)),
          ],
        ),
      ),
    );
  }
}