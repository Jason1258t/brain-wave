import 'package:brain_wave_2/feature/user_chats/ui/user_chat_screen.dart';
import 'package:brain_wave_2/logic/app_repository.dart';
import 'package:brain_wave_2/models/neuron_model.dart';
import 'package:brain_wave_2/utils/colors.dart';
import 'package:brain_wave_2/utils/fonts.dart';
import 'package:brain_wave_2/widgets/avatars/small_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class Users extends StatefulWidget {
  types.Room room;
  types.Message? lastMessage;
  Users({Key? key, required this.room, required this.lastMessage}) : super(key: key);

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  @override
  Widget build(BuildContext context) {
    Widget _buildAvatar(types.Room room) {
      var color = Colors.transparent;

      if (room.type == types.RoomType.direct) {
        try {
          final otherUser = room.users.firstWhere(
            (u) =>
                u.id !=
                RepositoryProvider.of<AppRepository>(context)
                    .getCurrentUser()!
                    .uid,
          );

          color = getUserAvatarNameColor(otherUser);
        } catch (e) {
          // Do nothing if other user is not found.
        }
      }

      final name = room.name ?? '';

      return SmallAvatar(
        name: name,
        avatar: room.imageUrl ?? '',
        color: color,
      );
    }

    String getLastMessage() {
      if (widget.lastMessage != null) {
        String text = widget.lastMessage!.toJson()['text'];
        return text.substring(0, text.length > 20 ? 20 : text.length);
      } else {
        return '';
      }
    }
    String getLastMessageTime() {
      try {
        DateTime time = DateTime.fromMillisecondsSinceEpoch(widget.lastMessage!.createdAt!);
        return "${time.hour}:${time.minute > 9 ? time.minute : '0${time.minute}'}";
      } catch (e) {
        return '';
      }
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => ChatPage(room: widget.room)));
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 80,
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: AppColors.widgetsBackground),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  _buildAvatar(widget.room),
                  const SizedBox(width: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.room.name ?? '',
                        style: AppTypography.font24lightBlue,
                      ),
                      Text(getLastMessage(), style: AppTypography.font14lightGrey,),
                    ],
                  ),
                ],
              ),
              Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                Text(getLastMessageTime(), style: AppTypography.font12lightGray,)
              ],)
            ],
          ),
        ),
      ),
    );
  }
}
