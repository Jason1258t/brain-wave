import 'package:flutter/material.dart';

class SmallAvatar extends StatelessWidget {
  String avatar;
  String name;

  //double size;

  SmallAvatar({Key? key, required this.avatar, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return avatar.isNotEmpty
        ? CircleAvatar(
            backgroundImage: NetworkImage(avatar),
            backgroundColor: Colors.white,
            radius: 25,
          )
        : CircleAvatar(
            backgroundColor: const Color(0xff5024CE),
            radius: 25,
            child: Text(
              name[0].toUpperCase(),
              style: const TextStyle(fontSize: 36, color: Colors.white),
            ),
          );
  }
}
