import 'dart:developer';

import 'package:brain_wave_2/logic/app_repository.dart';
import 'package:brain_wave_2/models/models.dart';
import 'package:brain_wave_2/services/api_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class UserAccountRepository {
  BehaviorSubject<LoadingStateEnum> userAccountState =
  BehaviorSubject<LoadingStateEnum>.seeded(LoadingStateEnum.wait);
}
