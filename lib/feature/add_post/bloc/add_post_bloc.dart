import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:brain_wave_2/feature/add_post/data/creating_post_repository.dart';
import 'package:brain_wave_2/logic/app_repository.dart';
import 'package:meta/meta.dart';

part 'add_post_event.dart';

part 'add_post_state.dart';

class AddPostBloc extends Bloc<AddPostEvent, AddPostState> {
  final PostCreatingRepository _postCreatingRepository;

  AddPostBloc({required PostCreatingRepository postCreatingRepository})
      : _postCreatingRepository = postCreatingRepository,
        super(AddPostInitial()) {
    on<AddPostSubscribeEvent>(_subscribe);
    on<AddPostInitialEvent>(_initialCreating);
    on<AddPostLoadingEvent>(_onLoading);
    on<AddPostSuccessEvent>(_onSuccess);
    on<AddPostFailEvent>(_onFail);
  }

  _subscribe(AddPostSubscribeEvent event, emit) {
    _postCreatingRepository.creatingState.stream.listen((event) {
      if (event == LoadingStateEnum.loading) add(AddPostLoadingEvent());
      if (event == LoadingStateEnum.success) add(AddPostSuccessEvent());
      if (event == LoadingStateEnum.fail) add(AddPostFailEvent());
    });
  }

  _initialCreating(AddPostInitialEvent event, emit) {
    _postCreatingRepository.createPost(
        title: event.title,
        description: event.description,
        image: event.image,
        uid: event.uid);
  }

  _onLoading(AddPostLoadingEvent event, emit) {
    emit(AddPostLoadingState());
  }

  _onSuccess(AddPostSuccessEvent event, emit) {
    emit(AddPostSuccessState());
  }

  _onFail(AddPostFailEvent event, emit) {
    emit(AddPostFailState());
  }
}
