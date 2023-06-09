import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationInitial()) {
    on<ViewProfileEvent>(_viewProfile);
  }

  _viewProfile(ViewProfileEvent event, emit) {
    emit(ViewProfileState());
  }
}
