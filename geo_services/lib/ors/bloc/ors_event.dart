part of 'ors_bloc.dart';

@immutable
class OrsEvent {}

class GetDirections extends OrsEvent {
  GetDirections({
    required this.startCoordinates,
    required this.endCoordinates,
  });

  final LatLng startCoordinates;
  final LatLng endCoordinates;
}
