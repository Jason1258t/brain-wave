part of 'neurons_bloc.dart';

@immutable
abstract class NeuronsEvent {}

class NeuronsSubscribeEvent extends NeuronsEvent {}

class NeuronsInitialLoadEvent extends NeuronsEvent {
  final bool f;
  NeuronsInitialLoadEvent({this.f = false});
}

class NeuronsLoadingEvent extends NeuronsEvent {}

class NeuronsSuccessEvent extends NeuronsEvent {}

class NeuronsFailEvent extends NeuronsEvent {}