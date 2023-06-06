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
    on<MessageSubscribeEvent>(_subscribe);
    on<MessageLoadingEvent>(_onLoading);
    on<MessageSuccessEvent>(_onSuccess);
    on<MessageSendEvent>(_sendMessage);
  }

  _subscribe(MessageSubscribeEvent event, emit) {
    _chatRepository.messageState.stream.listen((event) {
      if (event == LoadingStateEnum.loading) add(MessageLoadingEvent());
      if (event == LoadingStateEnum.success) add(MessageSuccessEvent());
    });
  }

  _onLoading(MessageLoadingEvent event, emit) {
    emit(MessageLoadingState());
  }

  _onSuccess(MessageSuccessEvent event, emit) {
    emit(MessageSuccessState());
  }

  _sendMessage(MessageSendEvent event, emit) {
    _chatRepository.messages
        .add(Message(isReverse: false, text: event.content, isLoad: false));

    _chatRepository.getMessageFromChatGBT(event.content);
  }
}
