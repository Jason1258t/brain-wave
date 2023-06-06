part of 'message_bloc.dart';

abstract class MessageEvent {}


class MessageSubscribeEvent extends MessageEvent {}

class MessageLoadingEvent extends MessageEvent {}

class MessageSuccessEvent extends MessageEvent {}

class MessageSendEvent extends MessageEvent {
  String content;

  MessageSendEvent({required this.content});
}
