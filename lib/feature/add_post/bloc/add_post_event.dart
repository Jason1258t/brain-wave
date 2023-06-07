part of 'add_post_bloc.dart';

abstract class AddPostEvent {}

class AddPostSubscribeEvent extends AddPostEvent {}

class AddPostInitialEvent extends AddPostEvent {
  final String title;
  final String description;
  final String uid;
  final File? image;

  AddPostInitialEvent(
      {required this.image,
      required this.uid,
      required this.description,
      required this.title});
}


class AddPostLoadingEvent extends AddPostEvent {}

class AddPostSuccessEvent extends AddPostEvent {}

class AddPostFailEvent extends AddPostEvent {}