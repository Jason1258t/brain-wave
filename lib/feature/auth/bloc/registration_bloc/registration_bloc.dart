import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:brain_wave_2/logic/app_repository.dart';
import 'package:meta/meta.dart';

part 'registration_event.dart';

part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final AppRepository _appRepository;
  late StreamSubscription _registerState;

  RegistrationBloc({required AppRepository appRepository})
      : _appRepository = appRepository,
        super(RegistrationInitial()) {
    on<RegisterSuccessEvent>(_onSuccessRegister);
    on<RegFirstScreenCheckValid>(_checkFirstReg);
    on<RegisterInitialEvent>(_initialRegistration);
    on<RegisterCompleteEvent>(_completeRegistration);
    on<RegisterSubscribeEvent>(_subscribe);
  }

  _subscribe(RegisterSubscribeEvent event, emit) {
    _registerState = _appRepository.authState.stream.listen((event) {
      if (event == AuthStateEnum.registered) add(RegisterSuccessEvent());
      if (event == AuthStateEnum.fail) add(RegisterFailEvent());
    });
  }

  _initialRegistration(RegisterInitialEvent event, emit) {
    _appRepository.firebaseRegisterUserWithEmailAndPassword(
        event.email, event.password, event.name);
  }

  _completeRegistration(RegisterCompleteEvent event, emit) {
    _appRepository.completeRegistration();
  }

  _onSuccessRegister(RegisterSuccessEvent event, emit) {
    emit(RegisterSuccessState());
  }
  _checkFirstReg(RegFirstScreenCheckValid event, emit) {
    if (event.email.isNotEmpty && event.name.isNotEmpty && event.firstPassword.isNotEmpty && event.secondPassword.isNotEmpty) {
      bool email = true;
      bool name = true;
      bool password = true;

      if (RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
          .hasMatch(event.email)) {
        email = false;
      }
      if (event.name.length > 2) {
        name = false;
      }
      if (event.firstPassword == event.secondPassword) {
        password = false;
      }
      if (email || name || password) {
        emit(FirstRegScreenInvalid(email: email, name: name, password: password));
      } else {
        emit(ValidRegState());
      }
    } else {
      emit(FirstRegScreenInvalid(email: true, name: true, password: true));
    }
  }
}
