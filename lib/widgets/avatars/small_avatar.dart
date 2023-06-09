import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/colors.dart';

class SmallAvatar extends StatefulWidget {
  String avatar;
  String name;
  Color? color;
  final _image;

  SmallAvatar({Key? key, required this.avatar, required this.name, this.color})
      : _image = NetworkImage(avatar),
        super(key: key);

  @override
  State<SmallAvatar> createState() => _SmallAvatarState();
}

class _SmallAvatarState extends State<SmallAvatar> {
  @override
  Widget build(BuildContext context) {
    return widget.avatar.isNotEmpty
            ? CircleAvatar(
                backgroundImage: widget._image,
                radius: 25,
              )
        : CircleAvatar(
            backgroundColor: widget.color ?? const Color(0xff5024CE),
            radius: 25,
            child: Text(
              widget.name[0].toUpperCase(),
              style: const TextStyle(fontSize: 36, color: Colors.white),
            ),
          );
  }
}
