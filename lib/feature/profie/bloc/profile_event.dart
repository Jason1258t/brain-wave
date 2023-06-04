part of 'profile_bloc.dart';

abstract class ProfileEvent {}

class ProfileSubscribeEvent extends ProfileEvent {}

class ProfilePostsInitialLoadEvent extends ProfileEvent {
  bool f;

  ProfilePostsInitialLoadEvent({this.f = false});
}

class ProfilePostsLoadingEvent extends ProfileEvent {}

class ProfilePostsSuccessEvent extends ProfileEvent {}

class ProfilePostsFailEvent extends ProfileEvent {}
