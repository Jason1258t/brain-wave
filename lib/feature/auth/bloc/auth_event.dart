part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthSubscriptionEvent extends AuthEvent {}

class LoginInitialEvent extends AuthEvent {
  final String email;
  final String password;

  LoginInitialEvent({required this.email, required this.password});
}

class GoogleAuthEvent extends AuthEvent {}

class LoginLoadingEvent extends AuthEvent {}

class LoginSuccessEvent extends AuthEvent {}

class LoginFailEvent extends AuthEvent {
  final String problem;

  LoginFailEvent({this.problem = 'ошибка'});
}

class LoginCheckValid extends AuthEvent {
  final String email;
  final String password;

  LoginCheckValid({required this.email, required this.password});
}
