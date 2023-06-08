import 'package:brain_wave_2/feature/profie/data/profile_repository.dart';
import 'package:brain_wave_2/models/post_model.dart';
import 'package:brain_wave_2/utils/colors.dart';
import 'package:brain_wave_2/utils/fonts.dart';
import 'package:brain_wave_2/widgets/avatars/small_avatar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  final List<String> postOptions = ['Удалить', 'Редактировать'];
  @override
  Widget build(BuildContext context) {
    void menuHandler(String? event) {
      if (event == 'Удалить') {
        RepositoryProvider.of<ProfileRepository>(context).deletePost(widget.post);
      } else if (event == 'Редактировать') {}
    }
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SmallAvatar(
                        avatar: widget.post.creatorImage,
                        name: widget.post.creatorName),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 220,
                          child: Text(
                            widget.post.title,
                            style: AppTypography.font20white,
                          ),
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
                  ],
                ),
                if (widget.post.isOwner)...[DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    isExpanded: true,
                    buttonStyleData: const ButtonStyleData(width: 30),
                    dropdownStyleData:
                    const DropdownStyleData(offset: Offset(-130, 0), width: 150),
                    customButton: const Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    ),
                    items: postOptions
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: AppTypography.font14milk),
                      );
                    }).toList(),
                    onChanged: menuHandler,
                  ),
                )]

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
            widget.post.image.isNotEmpty
                ? Container(
                    width: double.infinity,
                    height: 180,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(7)),
                        image: DecorationImage(
                            image: NetworkImage(
                              widget.post.image,
                            ),
                            fit: BoxFit.cover)),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
