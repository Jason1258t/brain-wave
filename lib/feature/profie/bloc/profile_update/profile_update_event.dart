part of 'profile_update_bloc.dart';

abstract class ProfileUpdateEvent {}

class UpdateLoadingEvent extends ProfileUpdateEvent {}

class UpdateSuccessEvent extends ProfileUpdateEvent {}

class UpdateFailEvent extends ProfileUpdateEvent {}

class UpdateNameEvent extends ProfileUpdateEvent {
  String name;
  UpdateNameEvent({required this.name});
}
