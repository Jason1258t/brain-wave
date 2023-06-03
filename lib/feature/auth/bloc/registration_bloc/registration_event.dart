part of 'registration_bloc.dart';

@immutable
abstract class RegistrationEvent {}

class RegisterSubscribeEvent extends RegistrationEvent {}

class RegisterInitialEvent extends RegistrationEvent {
  final String email;
  final String password;
  final String name;

  RegisterInitialEvent(
      {required this.email, required this.password, required this.name});
}

class RegisterCompleteEvent extends RegistrationEvent {}

class RegisterLoadingEvent extends RegistrationEvent {}

class RegisterSuccessEvent extends RegistrationEvent {}

class RegisterFailEvent extends RegistrationEvent {
  final String problem;

  RegisterFailEvent({this.problem = 'ошибка'});
}

class RegFirstScreenCheckValid extends RegistrationEvent {
  final String name;
  final String email;
  final String firstPassword;
  final String secondPassword;

  RegFirstScreenCheckValid(
      {required this.name,
        required this.email,
        required this.secondPassword,
        required this.firstPassword});
}

class RegValid extends RegistrationEvent {}
