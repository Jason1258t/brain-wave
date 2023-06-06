import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'neurons_event.dart';
part 'neurons_state.dart';

class NeuronsBloc extends Bloc<NeuronsEvent, NeuronsState> {
  NeuronsBloc() : super(NeuronsInitial()) {
    on<NeuronsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
