import 'package:brain_wave_2/models/message.dart';
import 'package:brain_wave_2/utils/colors.dart';
import 'package:brain_wave_2/utils/fonts.dart';
import 'package:flutter/material.dart';

class MessageWidget extends StatefulWidget {
  Message message;

  MessageWidget({Key? key, required this.message}) : super(key: key);

  @override
  State<MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
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
                  child: const CircularProgressIndicator(),
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
                    borderRadius: BorderRadius.circular(20),
                    color: widget.message.isReverse
                        ? AppColors.widgetsBackground
                        : AppColors.chatYour,
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    widget.message.text,
                    style: AppTypography.font24lightBlue,
                  ),
                ),
              ),
            ),
          );
  }
}
