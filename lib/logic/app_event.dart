part of 'app_bloc.dart';

@immutable
abstract class AppEvent {}


class AppSubscribeEvent extends AppEvent {}

class AppAuthEvent extends AppEvent {}

class AppUnAuthEvent extends AppEvent {}

class AppLogOutEvent extends AppEvent {}