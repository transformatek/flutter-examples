part of 'ors_bloc.dart';

@immutable
class OrsState {}

class OrsInitial extends OrsState {}

class OrsDirectionsLoaded extends OrsState {
  OrsDirectionsLoaded({required this.lineString});
  final LineString lineString;
}

class OrsDirectionsLoading extends OrsState {}

class OrsDirectionsError extends OrsState {
  OrsDirectionsError({required this.errorMessage});
  final String errorMessage;
}
