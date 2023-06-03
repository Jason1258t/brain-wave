import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:brain_wave_2/logic/app_repository.dart';
import 'package:meta/meta.dart';

part 'app_event.dart';

part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AppRepository _appRepository;
  late final StreamSubscription _appState;

  AppBloc({required AppRepository appRepository})
      : _appRepository = appRepository,
        super(AppInitial()) {
    on<AppSubscribeEvent>(_subscribe);
    on<AppAuthEvent>(_onAuth);
    on<AppUnAuthEvent>(_onUnAuth);
    on<AppLogOutEvent>(_onLogOut);
  }

  _subscribe(AppSubscribeEvent event, emit) {
    _appRepository.checkLogin();
    _appState = _appRepository.appState.stream.listen((event) {
      if (event == AppStateEnum.auth) add(AppAuthEvent());
      if (event == AppStateEnum.unAuth) add(AppUnAuthEvent());
    });
  }

  _onAuth(AppAuthEvent event, emit) {
    emit(AppAuthState());
    _appRepository.updateUser();
  }

  _onUnAuth(AppUnAuthEvent event, emit) {
    emit(AppUnAuthState());
  }

  _onLogOut(AppLogOutEvent event, emit) {
    _appRepository.logout();
  }
}
