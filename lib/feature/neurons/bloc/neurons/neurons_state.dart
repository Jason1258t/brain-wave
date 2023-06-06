part of 'neurons_bloc.dart';

@immutable
abstract class NeuronsState {}

class NeuronsInitial extends NeuronsState {}

class NeuronsLoadingState extends NeuronsState {}

class NeuronsSuccessState extends NeuronsState {}

class NeuronsFailState extends NeuronsState {}

