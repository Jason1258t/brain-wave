import 'package:flutter/material.dart';


class GoogleElevatedButton extends StatelessWidget {
  final VoidCallback callback;
  final String text;
  final double width;
  final double height;

  const GoogleElevatedButton(
      {Key? key,
        required this.callback,
        required this.text,
        this.width = 290,
        this.height = 55})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(7)),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(100, 74, 9, 181),
              blurRadius: 7,
              offset: Offset(0, 0),
            )
          ]),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            side: const BorderSide(
                color: Color.fromARGB(100, 74, 9, 181), width: 3),
            backgroundColor: const Color.fromARGB(13, 191, 111, 255),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(14),
              ),
            )),
        onPressed: callback,
        child: Row(
          children: [
            const SizedBox(
              width: 15,
            ),
            Image.asset(
              'Assets/google-icon.png',
              width: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                text,
                style: const TextStyle(
                  color: Color(0xff994FF7),
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}