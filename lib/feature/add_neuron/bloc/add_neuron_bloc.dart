import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:brain_wave_2/feature/add_neuron/data/neron_creating_repository.dart';
import 'package:brain_wave_2/logic/app_repository.dart';
import 'package:brain_wave_2/models/neuron_model.dart';
import 'package:meta/meta.dart';

part 'add_neuron_event.dart';

part 'add_neuron_state.dart';

class AddNeuronBloc extends Bloc<AddNeuronEvent, AddNeuronState> {
  final NeuronCreatingRepository _neuronCreatingRepository;

  AddNeuronBloc({required NeuronCreatingRepository neuronCreatingRepository})
      : _neuronCreatingRepository = neuronCreatingRepository,
        super(AddNeuronInitial()) {
    on<AddingSubscribeEvent>(_subscribe);
    on<AddInitialEvent>(_initialAdding);
    on<AddLoadingEvent>(_onLoading);
    on<AddSuccessEvent>(_onSuccess);
    on<AddFailEvent>(_onFail);
  }

  _subscribe(AddingSubscribeEvent event, emit) {
    _neuronCreatingRepository.creatingState.stream.listen((event) {
      if (event == LoadingStateEnum.loading) add(AddLoadingEvent());
      if (event == LoadingStateEnum.success) add(AddSuccessEvent());
      if (event == LoadingStateEnum.fail) add(AddFailEvent());
    });
  }

  _initialAdding(AddInitialEvent event, emit) {
    _neuronCreatingRepository.createNeuralNetwork(
        neuronModel: event.neuronModel,
        uid: event.uid,
        image: event.image,
        gitHub: event.gitHub);
  }

  _onLoading(AddLoadingEvent event, emit) {
    emit(AddNeuronLoadingState());
  }

  _onSuccess(AddSuccessEvent event, emit) {
    emit(AddNeuronSuccessState());
  }

  _onFail(AddFailEvent event, emit) {
    emit(AddNeuronFailState());
  }
}
