part of 'message_bloc.dart';

abstract class MessageState {}

class MessageInitial extends MessageState {}

class MessageLoadingState extends MessageState {}

class MessageSuccessState extends MessageState {}
