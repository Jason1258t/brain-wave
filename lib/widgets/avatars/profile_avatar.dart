import 'package:brain_wave_2/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProfileAvatar extends StatefulWidget {
  final String avatar;
  final String name;
  final _image;

  ProfileAvatar({Key? key, required this.avatar, required this.name})
      : _image = NetworkImage(avatar),
        super(key: key);

  @override
  State<ProfileAvatar> createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  bool isLoad = true;

  @override
  Widget build(BuildContext context) {
    widget._image.resolve(ImageConfiguration()).addListener(
      ImageStreamListener(
        (info, call) {
          isLoad = false;
          setState(() {});
        },
      ),
    );

    return CircleAvatar(
      backgroundColor: const Color(0xff0057FF),
      radius: 71,
      child: CircleAvatar(
        backgroundColor: const Color(0xff131124),
        radius: 69,
        child: widget.avatar.isNotEmpty
            ? isLoad
                ? Shimmer.fromColors(
                    baseColor: AppColors.background,
                    highlightColor: AppColors.purpleButton,
                    child: CircleAvatar(
                      backgroundImage: widget._image,
                      radius: 62,
                    ),
                  )
                : CircleAvatar(
                    backgroundImage: widget._image,
                    radius: 62,
                  )
            : CircleAvatar(
                backgroundColor: const Color(0xff5024CE),
                radius: 62,
                child: Text(
                  widget.name[0].toUpperCase(),
                  style: const TextStyle(fontSize: 64, color: Colors.white),
                ),
              ),
      ),
    );
  }
}

class ShimmerLoading extends StatefulWidget {
  const ShimmerLoading({
    super.key,
    required this.isLoading,
    required this.child,
  });

  final bool isLoading;
  final Widget child;

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading> {
  final _shimmerGradient = const LinearGradient(
    colors: [
      Colors.white,
      Colors.black,
      Colors.blue,
    ],
    stops: [
      0.1,
      0.3,
      0.4,
    ],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );

  @override
  Widget build(BuildContext context) {
    if (!widget.isLoading) {
      return widget.child;
    }

    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) {
        return _shimmerGradient.createShader(bounds);
      },
      child: widget.child,
    );
  }
}
