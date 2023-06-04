part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfilePostsLoadingState extends ProfileState {}

class ProfilePostsSuccessState extends ProfileState {}

class ProfilePostsFailState extends ProfileState {}
