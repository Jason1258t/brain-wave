part of 'user_account_bloc.dart';

abstract class UserAccountEvent {}

class UserSubscribeEvent extends UserAccountEvent {}

class UserInitialLoadEvent extends UserAccountEvent {
  final String uid;
  UserInitialLoadEvent({required this.uid});
}

class UserAccountLoadingEvent extends UserAccountEvent {}

class UserAccountSuccessEvent extends UserAccountEvent {}

class UserAccountFailEvent extends UserAccountEvent {}