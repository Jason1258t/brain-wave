import 'package:brain_wave_2/feature/user_chats/data/user_chats_repository.dart';
import 'package:brain_wave_2/feature/user_chats/ui/users_screen.dart';
import 'package:brain_wave_2/logic/app_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

import '../../../utils/utils.dart';
import 'user_chat_screen.dart';


class RoomsPage extends StatefulWidget {
  const RoomsPage({super.key});

  @override
  State<RoomsPage> createState() => _RoomsPageState();
}

class _RoomsPageState extends State<RoomsPage> {


  @override
  Widget build(BuildContext context) {
    final repository = RepositoryProvider.of<UserChatsRepository>(context);
    final appRepository = RepositoryProvider.of<AppRepository>(context);
    Widget _buildAvatar(types.Room room) {
      var color = Colors.transparent;

      if (room.type == types.RoomType.direct) {
        try {
          final otherUser = room.users.firstWhere(
                (u) => u.id != appRepository.getCurrentUser()!.uid,
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rooms'),
        backgroundColor: AppColors.purpleButton,
      ),
      body: StreamBuilder<List<types.Room>>(
        stream: FirebaseChatCore.instance.rooms(),
        initialData: const [],
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(
                bottom: 200,
              ),
              child: const Text('No rooms', style: TextStyle(color: Colors.white),),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final room = snapshot.data![index];

              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ChatPage(
                        room: room,
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      _buildAvatar(room),
                      Text(room.name ?? ''),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {Navigator.of(context).push(MaterialPageRoute(builder: (_) => const UsersPage()));},
        child: const Icon(Icons.add, color: Colors.white,),
      ),
    );
  }
}
