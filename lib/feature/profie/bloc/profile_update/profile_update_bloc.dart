import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:brain_wave_2/logic/app_repository.dart';
import 'package:meta/meta.dart';

part 'profile_update_event.dart';

part 'profile_update_state.dart';

class ProfileUpdateBloc extends Bloc<ProfileUpdateEvent, ProfileUpdateState> {
  final AppRepository _appRepository;

  ProfileUpdateBloc({required AppRepository appRepository})
      : _appRepository = appRepository,
        super(ProfileUpdateInitial()) {
    on<UpdateNameEvent>(_changeName);
    on<UpdateLoadingEvent>(_onLoading);
    on<UpdateSuccessEvent>(_onSuccess);
    on<UpdateFailEvent>(_onFail);
  }

  _changeName(UpdateNameEvent event, emit) {
    _appRepository.changeName(event.name);
    _appRepository.changeNameState.stream.listen((event) {
      if (event == LoadingStateEnum.loading) add(UpdateLoadingEvent());
      if (event == LoadingStateEnum.success) {
        add(UpdateSuccessEvent());
        return;
      }
      if (event == LoadingStateEnum.fail) {
        add(UpdateFailEvent());
        return;
      }
    });
  }

  _onLoading(UpdateLoadingEvent event, emit) {
    emit(UpdateLoadingState());
  }

  _onSuccess(UpdateSuccessEvent event, emit) {
    emit(UpdateSuccessState());
  }

  _onFail(UpdateFailEvent event, emit) {
    emit(UpdateFailState());
  }
}
