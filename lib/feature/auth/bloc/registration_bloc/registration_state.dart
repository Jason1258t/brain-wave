part of 'registration_bloc.dart';

@immutable
abstract class RegistrationState {}

class RegistrationInitial extends RegistrationState {}

class RegisterSuccessState extends RegistrationState {}

class RegisterLoadingState extends RegistrationState {}

class RegisterFailState extends RegistrationState {
  final String problem;
  RegisterFailState({this.problem = 'ошибка'});
}

class FirstRegScreenInvalid extends RegistrationState {
  final bool name;
  final bool email;
  final bool password;
  FirstRegScreenInvalid({required this.name, required this.email, required this.password});
}

class ValidRegState extends RegistrationState {}
