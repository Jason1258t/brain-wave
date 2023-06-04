import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:brain_wave_2/logic/app_repository.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AppRepository _appRepository;
  late StreamSubscription<AuthStateEnum> _authState;

  AuthBloc(
      {required AppRepository appRepository,})
      : _appRepository = appRepository,
        super(AuthInitial()) {
    on<AuthSubscriptionEvent>(_onSubscription);
    on<LoginInitialEvent>(_initialLogin);
    on<LoginLoadingEvent>(_onLoading);
    on<LoginSuccessEvent>(_onSuccessLogin);
    on<LoginFailEvent>(_onFail);
    on<LoginCheckValid>(_checkLoginValid);
    on<GoogleAuthEvent>(_initialGoogleAuth);
  }

  _onSubscription(AuthSubscriptionEvent event, emit) {
    _authState = _appRepository.authState.stream.listen((AuthStateEnum event) {
      if (event == AuthStateEnum.loading) add(LoginLoadingEvent());
      if (event == AuthStateEnum.logged) add(LoginSuccessEvent());
      if (event == AuthStateEnum.fail) add(LoginFailEvent());
    });
  }

  _initialLogin(LoginInitialEvent event, emit) {
    _appRepository.firebaseLoginUserWithEmailAndPassword(
        event.email, event.password);
  }

  _initialGoogleAuth(GoogleAuthEvent event, emit) {
    _appRepository.firebaseLoginWithGoogle();
  }

  _onLoading(LoginLoadingEvent event, emit) {
    emit(AuthLoadingState());
  }

  _onSuccessLogin(LoginSuccessEvent event, emit) {
    emit(AuthSuccessState());
  }

  _onFail(LoginFailEvent event, emit) {
    emit(AuthFailState());
  }

  _checkLoginValid(LoginCheckValid event, emit) {
    if (event.email.isNotEmpty && event.password.isNotEmpty) {
      bool email = true;
      bool password = true;

      if (RegExp(
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
          .hasMatch(event.email)) {
        email = false;
      }
      if (event.password.length > 5) {
        password = false;
      }
      if (email || password) {
        emit(LoginInvalidFields(email: email, password: password));
      } else {
        emit(LoginValidFields());
      }
    } else {
      emit(LoginInvalidFields(email: true, password: true));
    }
  }
}
