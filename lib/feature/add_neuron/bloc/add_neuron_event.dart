part of 'add_neuron_bloc.dart';

abstract class AddNeuronEvent {}

class AddingSubscribeEvent extends AddNeuronEvent {}

class AddInitialEvent extends AddNeuronEvent {
  final String uid;
  final String gitHub;
  final File? image;
  final NeuronModel neuronModel;
  AddInitialEvent({required this.uid, required this.image, required this.neuronModel, required this.gitHub});
}

class AddLoadingEvent extends AddNeuronEvent {}

class AddSuccessEvent extends AddNeuronEvent {}

class AddFailEvent extends AddNeuronEvent {}