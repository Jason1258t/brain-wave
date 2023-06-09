import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/colors.dart';

// ignore: must_be_immutable
class SmallAvatar extends StatefulWidget {
  String avatar;
  String name;
  Color? color;
  double radius;
  // ignore: prefer_typing_uninitialized_variables
  final _image;

  SmallAvatar({Key? key, required this.avatar, required this.name, this.color, this.radius = 25})
      : _image = NetworkImage(avatar),
        super(key: key);

  @override
  State<SmallAvatar> createState() => _SmallAvatarState();
}

class _SmallAvatarState extends State<SmallAvatar> {
  bool isLoad = true;

  @override
  Widget build(BuildContext context) {
    widget._image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
            (info, call) {
          isLoad = false;
          setState(() {});
        },
      ),
    );

    return widget.avatar.isNotEmpty
        ? !isLoad
        ? CircleAvatar(
      backgroundImage: widget._image,
      radius: widget.radius,
    )
        : Shimmer.fromColors(
      baseColor: AppColors.background,
      highlightColor: AppColors.purpleButton,
      child: CircleAvatar(
        backgroundImage: widget._image,
        radius: widget.radius,
      ),
    )
        : CircleAvatar(
      backgroundColor: widget.color ?? const Color(0xff5024CE),
      radius: widget.radius,
      child: Text(
        widget.name[0].toUpperCase(),
        style: const TextStyle(fontSize: 36, color: Colors.white),
      ),
    );
  }
}