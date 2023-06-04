part of 'news_bloc.dart';

@immutable
abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoadingState extends NewsState {}

class NewsSuccessState extends NewsState {}

class NewsFailState extends NewsState {}
