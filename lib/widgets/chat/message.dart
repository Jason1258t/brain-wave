import 'package:brain_wave_2/models/message.dart';
import 'package:brain_wave_2/utils/animations.dart';
import 'package:brain_wave_2/utils/colors.dart';
import 'package:brain_wave_2/utils/fonts.dart';
import 'package:flutter/material.dart';

var now = DateTime.now();

class MessageWidget extends StatefulWidget {
  Message message;

  MessageWidget({Key? key, required this.message}) : super(key: key);

  @override
  State<MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  String addEnter(String text){
    return text.length < 20 ? "$text      " : text;
  }

  @override
  Widget build(BuildContext context) {
    return widget.message.isLoad
        ? Container(
            padding: EdgeInsets.only(
                left: widget.message.isReverse
                    ? 14
                    : MediaQuery.of(context).size.width * 0.2,
                right: widget.message.isReverse
                    ? MediaQuery.of(context).size.width * 0.2
                    : 14,
                top: 10,
                bottom: 10),
            child: Align(
              alignment: (widget.message.isReverse
                  ? Alignment.topLeft
                  : Alignment.topRight),
              child: Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: widget.message.isReverse
                        ? AppColors.widgetsBackground
                        : AppColors.chatYour,
                  ),
                  padding: const EdgeInsets.all(16),
                  child: AppAnimations.bouncingLineChat,
                ),
              ),
            ),
          )
        : Container(
            padding: EdgeInsets.only(
                left: widget.message.isReverse
                    ? 14
                    : MediaQuery.of(context).size.width * 0.2,
                right: widget.message.isReverse
                    ? MediaQuery.of(context).size.width * 0.2
                    : 14,
                top: 10,
                bottom: 10),
            child: Align(
              alignment: (widget.message.isReverse
                  ? Alignment.topLeft
                  : Alignment.topRight),
              child: Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: widget.message.isReverse
                          ? Radius.zero
                          : const Radius.circular(10),
                      topRight: !widget.message.isReverse
                          ? Radius.zero
                          : const Radius.circular(10),
                      bottomLeft: const Radius.circular(10),
                      bottomRight: const Radius.circular(10),
                    ),
                    color: widget.message.isReverse
                        ? AppColors.widgetsBackground
                        : AppColors.chatYour,
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Chat GBT',
                            style: AppTypography.font13purple,
                          ),
                          Text(
                            addEnter(widget.message.text),
                            style: AppTypography.font24lightBlue,
                          ),
                        ],
                      ),
                      Text(
                        "${DateTime.now().hour} : ${DateTime.now().minute}",
                        style: AppTypography.font12lightGray,
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
