part of 'profile_update_bloc.dart';

@immutable
abstract class ProfileUpdateState {}

class ProfileUpdateInitial extends ProfileUpdateState {}

class UpdateLoadingState extends ProfileUpdateState {}

class UpdateSuccessState extends ProfileUpdateState {}

class UpdateFailState extends ProfileUpdateState {}
