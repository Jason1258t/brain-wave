import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:brain_wave_2/feature/user_account/data/user_account_repository.dart';
import 'package:brain_wave_2/logic/app_repository.dart';
import 'package:brain_wave_2/models/models.dart';
import 'package:meta/meta.dart';

part 'user_account_event.dart';

part 'user_account_state.dart';

class UserAccountBloc extends Bloc<UserAccountEvent, UserAccountState> {
  final UserAccountRepository _userAccountRepository;

  UserAccountBloc({required UserAccountRepository accountRepository})
      : _userAccountRepository = accountRepository,
        super(UserAccountInitial()) {
    on<UserSubscribeEvent>(_subscribe);
    on<UserInitialLoadEvent>(_initialLoad);
    on<UserAccountLoadingEvent>(_onLoading);
    on<UserAccountSuccessEvent>(_onSuccess);
    on<UserAccountFailEvent>(_onFail);
  }

  _subscribe(UserSubscribeEvent event, emit) {
    _userAccountRepository.userAccountState.stream.listen((event) {
      if (event == LoadingStateEnum.loading) add(UserAccountLoadingEvent());
      if (event == LoadingStateEnum.success) add(UserAccountSuccessEvent());
      if (event == LoadingStateEnum.fail) add(UserAccountFailEvent());
    });
  }

  _initialLoad(UserInitialLoadEvent event, emit) {
    _userAccountRepository.loadUserById(event.uid);
  }

  _onLoading(UserAccountLoadingEvent event, emit) {
    emit(UserAccountLoadingState());
  }

  _onSuccess(UserAccountSuccessEvent event, emit) {
    emit(UserAccountSuccessState(
        user: _userAccountRepository.getUser(),
        posts: _userAccountRepository.getPosts()));
  }

  _onFail(UserAccountFailEvent event, emit) {
    emit(UserAccountFailState());
  }
}
