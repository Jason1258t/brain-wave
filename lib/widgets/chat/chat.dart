import 'package:brain_wave_2/models/message.dart';
import 'package:brain_wave_2/utils/colors.dart';
import 'package:brain_wave_2/utils/fonts.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  Message message;

  Chat({Key? key, required this.message}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: widget.message.isReverse ? 14 : MediaQuery.of(context).size.width * 0.2,
          right: widget.message.isReverse ? MediaQuery.of(context).size.width * 0.2 : 14,
          top: 10,
          bottom: 10),
      child: Align(
        alignment:
            (widget.message.isReverse ? Alignment.topLeft : Alignment.topRight),
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
