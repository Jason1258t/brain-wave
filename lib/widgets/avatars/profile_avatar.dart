import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  String avatar;
  String name;
  int radius;

  ProfileAvatar({Key? key, required this.avatar, required this.name, this.radius = 71})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: const Color(0xff0057FF),
      radius: radius.toDouble(),
      child: CircleAvatar(
        backgroundColor: const Color(0xff131124),
        radius: radius - 2,
        child: avatar.isNotEmpty
            ? CircleAvatar(
                backgroundImage: NetworkImage(avatar),
                backgroundColor: Colors.white,
                radius: radius - 9,
              )
            : CircleAvatar(
                backgroundColor: const Color(0xff5024CE),
                radius: radius - 9,
                child: Text(
                  name[0].toUpperCase(),
                  style: const TextStyle(fontSize: 64, color: Colors.white),
                ),
              ),
      ),
    );
  }
}
