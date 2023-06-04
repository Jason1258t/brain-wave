part of 'news_bloc.dart';

@immutable
abstract class NewsEvent {}

class NewsSubscribeEvent extends NewsEvent {}

class NewsInitialLoadEvent extends NewsEvent {
  final bool f;
  NewsInitialLoadEvent({this.f = false});
}

class NewsLoadingEvent extends NewsEvent {}

class NewsSuccessEvent extends NewsEvent {}

class NewsFailEvent extends NewsEvent {}