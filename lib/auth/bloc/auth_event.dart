part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}


class LoginInitialEvent extends AuthEvent {
  final String email;
  final String password;
  LoginInitialEvent({required this.email, required this.password});
}

class LoginLoadingEvent extends AuthEvent {}

class LoginSuccessEvent extends AuthEvent {}

class LoginFailEvent extends AuthEvent {
  final String problem;
  LoginFailEvent({this.problem = 'ошибка'});
}

class RegisterInitialEvent extends AuthEvent {
  final String email;
  final String password;
  RegisterInitialEvent({required this.email, required this.password});
}

class RegisterLoadingEvent extends AuthEvent {}

class RegisterSuccessEvent extends AuthEvent {}

class RegisterFailEvent extends AuthEvent {
  final String problem;
  RegisterFailEvent({this.problem = 'ошибка'});
}