import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  String avatar;
  String name;

  ProfileAvatar({Key? key, required this.avatar, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: const Color(0xff0057FF),
      radius: 71,
      child: CircleAvatar(
        backgroundColor: const Color(0xff131124),
        radius: 69,
        child: avatar.isNotEmpty
            ? CircleAvatar(
                backgroundImage: NetworkImage(avatar),
                backgroundColor: Colors.white,
                radius: 62,
              )
            : CircleAvatar(
                backgroundColor: const Color(0xff5024CE),
                radius: 62,
                child: Text(
                  name[0].toUpperCase(),
                  style: const TextStyle(fontSize: 64, color: Colors.white),
                ),
              ),
      ),
    );
  }
}
