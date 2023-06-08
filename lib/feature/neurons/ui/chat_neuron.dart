import 'package:brain_wave_2/feature/neurons/data/chat/chat_repository.dart';
import 'package:brain_wave_2/utils/colors.dart';
import 'package:brain_wave_2/utils/fonts.dart';
import 'package:brain_wave_2/widgets/chat/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/message/message_bloc.dart';

class ChatNeuron extends StatefulWidget {
  const ChatNeuron({Key? key}) : super(key: key);

  @override
  State<ChatNeuron> createState() => _ChatNeuronState();
}

class _ChatNeuronState extends State<ChatNeuron> {
  TextEditingController messageController = TextEditingController();
  final ScrollController _controller = ScrollController();

  void scrollDown() {
    _controller.animateTo(
      _controller.position.minScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    ChatRepository _chatRepository =
        RepositoryProvider.of<ChatRepository>(context);

    return BlocConsumer<MessageBloc, MessageState>(
      listener: (context, state) {
        scrollDown();
      },
      builder: (context, state) {
        return Scaffold(
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
                        color: AppColors.lightGrayText,
                      ),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    const CircleAvatar(
                      backgroundImage: AssetImage('Assets/chatGBT.png'),
                      maxRadius: 20,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          Text(
                            "Chat GBT",
                            style: AppTypography.font18lightBlue,
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text("Online", style: AppTypography.font13grey),
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
          body: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColors.background,
                  ),
                  child: ListView(
                    reverse: true,
                    controller: _controller,
                    children: _chatRepository.messages.reversed
                        .map((e) => MessageWidget(
                              message: e,
                            ))
                        .toList(),
                  ),
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
                      color: AppColors.chatUnderField,
                      child: Row(
                        children: <Widget>[
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: TextField(
                              controller: messageController,
                              style: AppTypography.font14lightGrey,
                              decoration: const InputDecoration(
                                  hintText: "Write message...",
                                  hintStyle: AppTypography.font14lightGrey,
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
                                BlocProvider.of<MessageBloc>(context).add(
                                    MessageSendEvent(
                                        content:
                                            messageController.text.trim()));
                                messageController.text = '';
                              }
                            },
                            backgroundColor: AppColors.purpleButton,
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
