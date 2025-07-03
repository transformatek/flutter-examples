part of 'photon_bloc.dart';

class PhotonEvent {}

class GetRecentResearch extends PhotonEvent {}

class GetSelectionLocation extends PhotonEvent {
  GetSelectionLocation({required this.address, required this.localeLanguage});
  final String address;
  final String localeLanguage;
}

class GetSelectionAddress extends PhotonEvent {
  GetSelectionAddress({required this.coordinates});
  final LatLng coordinates;
}
