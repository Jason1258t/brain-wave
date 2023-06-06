import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:brain_wave_2/feature/neurons/data/chat_repository.dart';
import 'package:brain_wave_2/logic/app_repository.dart';
import 'package:brain_wave_2/models/message.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'message_event.dart';

part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final ChatRepository _chatRepository;

  MessageBloc({required ChatRepository chatRepository})
      : _chatRepository = chatRepository,
        super(MessageInitial()) {

  }


}
