import 'package:bloc/bloc.dart';
import 'package:brain_wave_2/feature/news/data/news_repository.dart';
import 'package:meta/meta.dart';

part 'news_event.dart';

part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository _newsRepository;

  NewsBloc({required NewsRepository newsRepository})
      : _newsRepository = newsRepository,
        super(NewsInitial()) {
    on<NewsSubscribeEvent>(_subscribe);
    on<NewsInitialLoadEvent>(_onInitialLoad);
    on<NewsLoadingEvent>(_onLoading);
    on<NewsSuccessEvent>(_onSuccess);
    on<NewsFailEvent>(_onFail);
  }

  _subscribe(NewsSubscribeEvent event, emit) {
  }

  _onInitialLoad(NewsInitialLoadEvent event, emit) {
    _newsRepository.loadNews(event.f);
  }

  _onLoading(NewsLoadingEvent event, emit) {
    emit(NewsLoadingState());
  }

  _onSuccess(NewsSuccessEvent event, emit) {
    emit(NewsSuccessState());
  }

  _onFail(NewsFailEvent event, emit) {
    emit(NewsFailState());
  }
}
