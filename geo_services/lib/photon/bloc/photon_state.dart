part of 'photon_bloc.dart';

class PhotonState {}

class PhotonInitial extends PhotonState {}

class AddressListLoaded extends PhotonState {
  AddressListLoaded({required this.photonResponse});
  final PhotonAddressResponseModel photonResponse;
}

class AddressListLoading extends PhotonState {}
