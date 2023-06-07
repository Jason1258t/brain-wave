import 'package:brain_wave_2/feature/neurons/bloc/message/message_bloc.dart';
import 'package:brain_wave_2/models/message.dart';
import 'package:brain_wave_2/utils/colors.dart';
import 'package:brain_wave_2/utils/fonts.dart';
import 'package:brain_wave_2/widgets/chat/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatUser extends StatefulWidget {
  final bool isAttachmentUploading;
  final List<types.Message> messageList;
  final onAttachmentPressed;
  final onMessageTap;
  final onPreviewDataFetched;
  final onSendPressed;
  final types.User user;

  const ChatUser(
      {Key? key,
      required this.isAttachmentUploading,
      required this.messageList,
      required this.onAttachmentPressed,
      required this.onMessageTap,
      required this.onPreviewDataFetched,
      required this.onSendPressed,
      required this.user})
      : super(key: key);

  @override
  State<ChatUser> createState() => _ChatUserState();
}

class _ChatUserState extends State<ChatUser> {
  TextEditingController messageController = TextEditingController();
  final ScrollController _controller = ScrollController();

  void scrollDown() {
    _controller.animateTo(
      _controller.position.minScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  String getTime(int ms) {
    final String hour = "${DateTime.fromMillisecondsSinceEpoch(ms).hour}";
    final intMinute = DateTime.fromMillisecondsSinceEpoch(ms).minute;
    late String minute;
    if (intMinute > 9) {
      minute = intMinute.toString();
    } else {
      minute = '0$intMinute';
    }
    return "$hour:$minute";
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MessageBloc, MessageState>(
      listener: (context, state) {
        scrollDown();
      },
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColors.background,
                  ),
                  child: ListView(
                      reverse: true,
                      controller: _controller,
                      children: widget.messageList
                          .map((e) => MessageWidget(
                              message: Message(
                                  createdAt: getTime(e.createdAt!),
                                  authorName: e.author.id != widget.user.id
                                      ? e.author.firstName ?? ''
                                      : 'Вы',
                                  authorImage: e.author.imageUrl ?? '',
                                  isReverse: e.author.id != widget.user.id,
                                  isLoad: false,
                                  text: e.toJson()['text'])))
                          .toList()),
                ),
              ),
              Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      padding:
                          const EdgeInsets.only(left: 10, bottom: 10, top: 10),
                      height: 60,
                      width: double.infinity,
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            flex: 1,
                            child: TextField(
                              controller: messageController,
                              decoration: const InputDecoration(
                                  hintText: "Write message...",
                                  hintStyle: TextStyle(color: Colors.black54),
                                  border: InputBorder.none),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          FloatingActionButton(
                            onPressed: () async {
                              scrollDown();
                              if (messageController.text.isNotEmpty) {
                                widget.onSendPressed(types.PartialText(
                                    text: messageController.text));
                                messageController.text = '';
                              }
                            },
                            backgroundColor: Colors.blue,
                            elevation: 0,
                            child: const Icon(
                              Icons.send,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
