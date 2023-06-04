import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:brain_wave_2/feature/profie/data/profile_repository.dart';
import 'package:brain_wave_2/logic/app_repository.dart';
import 'package:flutter/rendering.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _profileRepository;
  late StreamSubscription _postsLoadingState;

  ProfileBloc({required ProfileRepository profileRepository})
      : _profileRepository = profileRepository,
        super(ProfileInitial()) {
    on<ProfileSubscribeEvent>(_subscribe);
    on<ProfilePostsLoadingEvent>(_onLoading);
    on<ProfilePostsSuccessEvent>(_onSuccess);
    on<ProfilePostsFailEvent>(_onFail);
    on<ProfilePostsInitialLoadEvent>(_initialLoad);
  }

  _subscribe(ProfileSubscribeEvent event, emit) {
    _postsLoadingState = _profileRepository.postsLoading.stream.listen((event) {
      if (event == LoadingStateEnum.loading) add(ProfilePostsLoadingEvent());
      if (event == LoadingStateEnum.success) add(ProfilePostsSuccessEvent());
      if (event == LoadingStateEnum.fail) add(ProfilePostsFailEvent());
    });
  }

  _initialLoad(ProfilePostsInitialLoadEvent event, emit) {
    _profileRepository.initialLoadPosts(f: event.f);
  }

  _onLoading(ProfilePostsLoadingEvent event, emit) {
    emit(ProfilePostsLoadingState());
  }

  _onFail(ProfilePostsFailEvent event, emit) {
    emit(ProfilePostsFailState());
  }

  _onSuccess(ProfilePostsSuccessEvent event, emit) {
    emit(ProfilePostsSuccessState());
  }
}
