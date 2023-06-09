part of 'user_account_bloc.dart';

@immutable
abstract class UserAccountState {}

class UserAccountInitial extends UserAccountState {}

class UserAccountLoadingState extends UserAccountState {}

class UserAccountSuccessState extends UserAccountState {
  final UserModel user;
  UserAccountSuccessState({required this.user});
}

class UserAccountFailState extends UserAccountState {}
