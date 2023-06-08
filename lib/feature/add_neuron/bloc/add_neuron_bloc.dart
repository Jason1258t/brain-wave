import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_neuron_event.dart';
part 'add_neuron_state.dart';

class AddNeuronBloc extends Bloc<AddNeuronEvent, AddNeuronState> {
  AddNeuronBloc() : super(AddNeuronInitial()) {
    on<AddNeuronEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
