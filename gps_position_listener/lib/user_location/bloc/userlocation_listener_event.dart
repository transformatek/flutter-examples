part of 'userlocation_listener_bloc.dart';

@immutable
abstract class UserlocationListenerEvent {}

class StartLocationListener extends UserlocationListenerEvent {}

class StopLocationListener extends UserlocationListenerEvent {}
