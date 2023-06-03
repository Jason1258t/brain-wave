part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthSuccessState extends AuthState {}

class AuthFailState extends AuthState {}

class LoginInvalidFields extends AuthState {
  final bool email;
  final bool password;
  LoginInvalidFields({required this.email, required this.password});
}

class LoginValidFields extends AuthState {}