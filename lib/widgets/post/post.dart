import 'package:brain_wave_2/models/post_model.dart';
import 'package:brain_wave_2/utils/colors.dart';
import 'package:brain_wave_2/utils/fonts.dart';
import 'package:brain_wave_2/widgets/avatars/small_avatar.dart';
import 'package:flutter/material.dart';

class Post extends StatefulWidget {
  PostModel post;

  Post({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      decoration: const BoxDecoration(
        color: AppColors.widgetsBackground,
        borderRadius: BorderRadius.all(Radius.circular(14)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SmallAvatar(
                        avatar: widget.post.creatorImage,
                        name: widget.post.creatorName),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.post.title,
                            style: AppTypography.font20white,
                          ),
                          const SizedBox(
                            height: 9,
                          ),
                          Text(
                            widget.post.creatorName,
                            style: AppTypography.font14milk,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    ))
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              widget.post.description,
              softWrap: true,
              style: AppTypography.font16white,
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              width: double.infinity,
              height: 140,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(7)),
                  image: DecorationImage(
                      image: AssetImage(
                        widget.post.image,
                      ),
                      fit: BoxFit.cover)),
            ),
          ],
        ),
      ),
    );
  }
}
