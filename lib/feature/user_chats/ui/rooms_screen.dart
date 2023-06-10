import 'package:brain_wave_2/feature/home/bloc/navigation_bloc.dart';
import 'package:brain_wave_2/feature/user_chats/ui/users_screen.dart';
import 'package:brain_wave_2/logic/app_repository.dart';
import 'package:brain_wave_2/widgets/avatars/small_avatar.dart';
import 'package:brain_wave_2/widgets/container_info/user/user_container.dart';
import 'package:brain_wave_2/widgets/text_fields/search_text_field.dart';
import 'package:flutter/material.dart';
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
    final TextEditingController queryController = TextEditingController();
    final chatCore = RepositoryProvider.of<AppRepository>(context).chatCore;
    return Scaffold(
      body: StreamBuilder<List<types.Room>>(
        stream: FirebaseChatCore.instance.rooms(),
        initialData: const [],
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return const Center(
                child: Text(
                  'Нет чатов',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
          }
          return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.background,
              ),
              child: SafeArea(
                  child: Padding(
                padding: const EdgeInsets.only(top: 13, left: 30, right: 30),
                child: Column(children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Чаты',
                        style: AppTypography.font24lightBlue,
                      ),
                      GestureDetector(
                        onTap: () async {
                          BlocProvider.of<NavigationBloc>(context)
                              .add(ViewProfileEvent());
                        },
                        child: SmallAvatar(
                            avatar:
                                RepositoryProvider.of<AppRepository>(context)
                                        .getCurrentUser()!
                                        .photoURL ??
                                    '',
                            name: RepositoryProvider.of<AppRepository>(context)
                                .getCurrentUser()!
                                .displayName!),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomSearchField(
                    hintText: 'Поиск чатов',
                    controller: queryController,
                    callback: (q) {},
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 70,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: ListView.builder(
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
                          child: StreamBuilder<types.Room>(
                              initialData: room,
                              stream: chatCore.room(room.id),
                              builder: (context, snapshot) {
                                if (snapshot.data != null) {
                                  return StreamBuilder<List<types.Message>>(
                                      initialData: const [],
                                      stream: chatCore.messages(snapshot.data!),
                                      builder: (context, snapshot) {
                                        if (snapshot.data != null) {
                                          if (snapshot.data!.isNotEmpty) {
                                            return Users(
                                              lastMessage: snapshot.data!.first,
                                              room: room,
                                            );
                                          } else {
                                            return Users(
                                              lastMessage: null,
                                              room: room,
                                            );
                                          }
                                        } else {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AppAnimations.bouncingLine
                                            ],
                                          );
                                        }
                                      });
                                } else {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [AppAnimations.bouncingLine],
                                  );
                                }
                              }),
                        );
                      },
                    ),
                  ),
                ]),
              )));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => const UsersPage()));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
