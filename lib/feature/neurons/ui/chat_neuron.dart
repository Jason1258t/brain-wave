import 'package:brain_wave_2/feature/neurons/data/chat_repository.dart';
import 'package:brain_wave_2/models/message.dart';
import 'package:brain_wave_2/utils/colors.dart';
import 'package:brain_wave_2/utils/fonts.dart';
import 'package:brain_wave_2/widgets/chat/chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Message chats = Message(
    isReverse: true,
    text:
        'teasfasdfaskdjfhaskjdfhakjsdmnbmnbmnbmnbm,nbmnbmnbm,bm,nbhflkasjdfxt');
Message chatS = Message(isReverse: false, text: 'text');

List messenges = [
  chats,
  chatS,
  chats,
  chatS,
  chats,
  chatS,
  chats,
  chatS,
  chats,
  chatS,
  chats,
  chatS,
  chats,
  chatS,
  chats,
  chatS,
  chats,
  chatS,
];

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
                    color: Colors.black,
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
                children: messenges.reversed
                    .map((e) => Chat(
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
                  padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
                  height: 60,
                  width: double.infinity,
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
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
                            messenges.add(Message(
                                isReverse: false,
                                text: messageController.text));
                            messenges.add(Message(isReverse: true, text: await RepositoryProvider.of<ChatRepository>(context).getChat(messageController.text)));
                          }
                          messageController.text = '';

                          setState(() {});
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
  }
}
