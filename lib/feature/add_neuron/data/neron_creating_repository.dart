import 'dart:io';

import 'package:brain_wave_2/logic/app_repository.dart';
import 'package:brain_wave_2/models/neuron_model.dart';
import 'package:brain_wave_2/services/api_service.dart';
import 'package:rxdart/rxdart.dart';

class NeuronCreatingRepository {
  final ApiService _apiService;

  NeuronCreatingRepository({required ApiService apiService})
      : _apiService = apiService;

  BehaviorSubject<LoadingStateEnum> creatingState =
      BehaviorSubject<LoadingStateEnum>.seeded(LoadingStateEnum.wait);

  void createNeuralNetwork(
      {required NeuronModel neuronModel,
        required String gitHub,
      required String uid,
      required File? image}) async {
    creatingState.add(LoadingStateEnum.loading);
    try {
      _apiService.createNeuron(
          name: neuronModel.name,
          uid: uid,
          gitHub: gitHub,
          image: image,
          hashtag: neuronModel.hashtag,
          description: neuronModel.description);

      creatingState.add(LoadingStateEnum.success);
    } catch (e) {
      creatingState.add(LoadingStateEnum.fail);
    }
  }
}
