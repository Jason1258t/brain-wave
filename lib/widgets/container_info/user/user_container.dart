import 'package:brain_wave_2/logic/app_repository.dart';
import 'package:brain_wave_2/models/neuron_model.dart';
import 'package:brain_wave_2/utils/colors.dart';
import 'package:brain_wave_2/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class Users extends StatefulWidget {
  types.Room room;
  Users({Key? key, required this.room}) : super(key: key);

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
                (u) => u.id != RepositoryProvider.of<AppRepository>(context).getCurrentUser()!.uid,
          );

          color = getUserAvatarNameColor(otherUser);
        } catch (e) {
          // Do nothing if other user is not found.
        }
      }

      final hasImage = room.imageUrl != null;
      final name = room.name ?? '';

      return Container(
        margin: const EdgeInsets.only(right: 16),
        child: CircleAvatar(
          backgroundColor: hasImage ? Colors.transparent : color,
          backgroundImage: hasImage ? NetworkImage(room.imageUrl!) : null,
          radius: 20,
          child: !hasImage
              ? Text(
            name.isEmpty ? '' : name[0].toUpperCase(),
            style: const TextStyle(color: Colors.white),
          )
              : null,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: InkWell(
        onTap: () {Navigator.pushNamed(context, '/chat_user');},
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 80,
          decoration: const BoxDecoration(
            color: AppColors.widgetsBackground,
            borderRadius: BorderRadius.all(Radius.circular(14)),
          ),
          child: Expanded(
            child: Row(
              children: [
                _buildAvatar(widget.room),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.room.name ?? '', style: AppTypography.font24lightBlue,),
                    Text(widget.room.lastMessages != null ? widget.room.lastMessages![0].toJson()['text'] : ''),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
