part of 'userlocation_listener_bloc.dart';

@immutable
abstract class UserlocationListenerState {}

class UserlocationListenerInitial extends UserlocationListenerState {}

class LocationLoaded extends UserlocationListenerState {
  LocationLoaded({required this.location});
  final LatLng location;
}
