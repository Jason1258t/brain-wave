import 'package:flutter/material.dart';

class SmallAvatar extends StatelessWidget {
  String avatar;
  String name;
  Color? color;
  double radius;

  //double size;

  SmallAvatar({Key? key, required this.avatar, required this.name, this.color, this.radius = 25})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return avatar.isNotEmpty
        ? CircleAvatar(
            backgroundImage: NetworkImage(avatar),
            backgroundColor: Colors.white,
            radius: radius,
          )
        : CircleAvatar(
            backgroundColor: color ?? const Color(0xff5024CE),
            radius: radius,
            child: Text(
              name[0].toUpperCase(),
              style: const TextStyle(fontSize: 36, color: Colors.white),
            ),
          );
  }
}
