import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:brain_wave_2/logic/app_repository.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AppRepository _appRepository;


  AuthBloc({required AppRepository appRepository}) :_appRepository = appRepository, super(AuthInitial()) {
    on<AuthEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
