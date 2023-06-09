part of 'add_neuron_bloc.dart';

@immutable
abstract class AddNeuronState {}

class AddNeuronInitial extends AddNeuronState {}

class AddNeuronLoadingState extends AddNeuronState {}

class AddNeuronSuccessState extends AddNeuronState {}

class AddNeuronFailState extends AddNeuronState {}
