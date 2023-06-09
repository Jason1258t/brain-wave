part of 'user_account_bloc.dart';

@immutable
abstract class UserAccountState {}

class UserAccountInitial extends UserAccountState {}

class UserAccountLoadingState extends UserAccountState {}

class UserAccountSuccessState extends UserAccountState {
  final UserModel user;
  final List<PostModel> posts;
  UserAccountSuccessState({required this.user, required this.posts});
}

class UserAccountFailState extends UserAccountState {}
