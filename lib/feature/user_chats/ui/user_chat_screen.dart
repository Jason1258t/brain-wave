import 'dart:io';

import 'package:brain_wave_2/feature/user_chats/ui/users_chat.dart';
import 'package:brain_wave_2/logic/app_repository.dart';
import 'package:brain_wave_2/utils/animations.dart';
import 'package:brain_wave_2/utils/colors.dart';
import 'package:brain_wave_2/utils/fonts.dart';
import 'package:brain_wave_2/widgets/avatars/small_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:http/http.dart' as http;
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
    required this.room,
  });

  final types.Room room;

  @override
  State<ChatPage> createState() => _ChatPageState();
}


class _ChatPageState extends State<ChatPage> {
  bool _isAttachmentUploading = false;

  void _handleAtachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => SafeArea(
        child: SizedBox(
          height: 144,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Cancel'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleMessageTap(BuildContext _, types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        try {
          final updatedMessage = message.copyWith(isLoading: true);
          FirebaseChatCore.instance.updateMessage(
            updatedMessage,
            widget.room.id,
          );

          final client = http.Client();
          final request = await client.get(Uri.parse(message.uri));
          final bytes = request.bodyBytes;
          final documentsDir = (await getApplicationDocumentsDirectory()).path;
          localPath = '$documentsDir/${message.name}';

          if (!File(localPath).existsSync()) {
            final file = File(localPath);
            await file.writeAsBytes(bytes);
          }
        } finally {
          final updatedMessage = message.copyWith(isLoading: false);
          FirebaseChatCore.instance.updateMessage(
            updatedMessage,
            widget.room.id,
          );
        }
      }

      await OpenFilex.open(localPath);
    }
  }

  void _handlePreviewDataFetched(
      types.TextMessage message,
      types.PreviewData previewData,
      ) {
    final updatedMessage = message.copyWith(previewData: previewData);

    FirebaseChatCore.instance.updateMessage(updatedMessage, widget.room.id);
  }

  void _handleSendPressed(types.PartialText message) {
    FirebaseChatCore.instance.sendMessage(
      message,
      widget.room.id,
    );
  }

  void _setAttachmentUploading(bool uploading) {
    setState(() {
      _isAttachmentUploading = uploading;
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatCore = RepositoryProvider.of<AppRepository>(context).chatCore;
    return  Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.appBarChat,
        flexibleSpace: SafeArea(
          child: Container(
            height: 60,
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/user_account_screen');
                      },
                    child: SmallAvatar(avatar: widget.room.imageUrl ?? '', name: widget.room.name!)
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        widget.room.name ?? '',
                        style: AppTypography.font18lightBlue,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      const Text("Online", style: AppTypography.font13grey),
                    ],
                  ),
                ),
                const Icon(
                  Icons.settings,
                  color: AppColors.lightGrayText,
                ),
              ],
            ),
          ),
        ),
      ),
      body: StreamBuilder<types.Room>(
        initialData: widget.room,
        stream: chatCore.room(widget.room.id),
        builder: (context, snapshot) => snapshot.data != null ?  StreamBuilder<List<types.Message>>(
            initialData: const [],
            stream: chatCore.messages(snapshot.data!),
            builder: (context, snapshot) => snapshot.data != null ? ChatUser(
              isAttachmentUploading: _isAttachmentUploading,
              messageList: snapshot.data ?? [],
              onAttachmentPressed: _handleAtachmentPressed,
              onMessageTap: _handleMessageTap,
              onPreviewDataFetched: _handlePreviewDataFetched,
              onSendPressed: _handleSendPressed,
              user: types.User(
                id: chatCore.firebaseUser!.uid ?? '',
              ),
            ) : AppAnimations.bouncingLine
        ) : Container(),
      ),
    );
  }
}
