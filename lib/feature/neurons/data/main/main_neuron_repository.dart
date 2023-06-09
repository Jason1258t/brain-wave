import 'package:brain_wave_2/logic/app_repository.dart';
import 'package:brain_wave_2/models/neuron_model.dart';
import 'package:brain_wave_2/services/api_service.dart';
import 'package:rxdart/subjects.dart';

class NeuronsRepository{
  final ApiService _apiService;
  int currentNeuron = -1;

  void setCurrentNeuron(int index) => currentNeuron = index;

  NeuronsRepository({required ApiService apiService}) : _apiService = apiService;

  BehaviorSubject<LoadingStateEnum> neuronsState =
  BehaviorSubject<LoadingStateEnum>.seeded(LoadingStateEnum.wait);

  List<NeuronModel> neurons = [];

  List<NeuronModel> getNeurons() => neurons;

  void loadNews(bool f) async {
    if (f || neurons.isEmpty) {
      neuronsState.add(LoadingStateEnum.loading);
      try {
        final news = await _apiService.loadAllNeurons();
        neurons = news;

        neuronsState.add(LoadingStateEnum.success);
      } catch (e) {
        neuronsState.add(LoadingStateEnum.fail);
        rethrow;
      }
    }

  }
}