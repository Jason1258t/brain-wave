import 'package:bloc/bloc.dart';
import 'package:brain_wave_2/feature/neurons/data/main/main_neuron_repository.dart';
import 'package:brain_wave_2/logic/app_repository.dart';
import 'package:meta/meta.dart';

part 'neurons_event.dart';
part 'neurons_state.dart';

class NeuronsBloc extends Bloc<NeuronsEvent, NeuronsState> {
  final NeuronsRepository _neuronsRepository;

  NeuronsBloc({required NeuronsRepository neuronsRepository})
      : _neuronsRepository = neuronsRepository,
        super(NeuronsInitial()) {
    on<NeuronsSubscribeEvent>(_subscribe);
    on<NeuronsInitialLoadEvent>(_onInitialLoad);
    on<NeuronsLoadingEvent>(_onLoading);
    on<NeuronsSuccessEvent>(_onSuccess);
    on<NeuronsFailEvent>(_onFail);
  }

  _subscribe(NeuronsSubscribeEvent event, emit) {
   _neuronsRepository.neuronsState.stream.listen((event) {
      if (event == LoadingStateEnum.loading) add(NeuronsLoadingEvent());
      if (event == LoadingStateEnum.success) add(NeuronsSuccessEvent());
      if (event == LoadingStateEnum.fail) add(NeuronsFailEvent());
    });
  }

  _onInitialLoad(NeuronsInitialLoadEvent event, emit) {
    _neuronsRepository.loadNews(event.f);
  }

  _onLoading(NeuronsLoadingEvent event, emit) {
    emit(NeuronsLoadingState());
  }

  _onSuccess(NeuronsSuccessEvent event, emit) {
    emit(NeuronsSuccessState());
  }

  _onFail(NeuronsFailEvent event, emit) {
    emit(NeuronsFailState());
  }
}
