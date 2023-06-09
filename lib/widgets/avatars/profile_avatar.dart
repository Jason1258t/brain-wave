import 'package:brain_wave_2/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProfileAvatar extends StatelessWidget {
  String avatar;
  String name;
  final _image;
  int radius;

  ProfileAvatar({Key? key, required this.avatar, required this.name, this.radius = 71})
      : _image = NetworkImage(avatar),
        super(key: key);

  @override
  State<ProfileAvatar> createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  bool isLoad = true;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: const Color(0xff0057FF),
      radius: radius.toDouble(),
      child: CircleAvatar(
        backgroundColor: const Color(0xff131124),
        radius: widget.radius - 2,
        child: widget.avatar.isNotEmpty
            ? isLoad
                ? Shimmer.fromColors(
                    baseColor: AppColors.background,
                    highlightColor: AppColors.purpleButton,
                    child: CircleAvatar(
                      backgroundImage: widget._image,
                      radius: widget.radius - 9,
                    ),
                  )
                : CircleAvatar(
                    backgroundImage: widget._image,
                    radius: widget.radius - 9,
                  )
            : CircleAvatar(
                backgroundColor: const Color(0xff5024CE),
                radius: widget.radius - 9,
                child: Text(
                  widget.name[0].toUpperCase(),
                  style: const TextStyle(fontSize: 64, color: Colors.white),
                ),
              ),
      ),
    );
  }
}
