import 'package:bloc/bloc.dart';
import 'package:latlong2/latlong.dart';

import '../models/photon_address_response_model.dart';
import '../photon_service.dart';

part 'photon_event.dart';
part 'photon_state.dart';

class PhotonBloc extends Bloc<PhotonEvent, PhotonState> {
  PhotonServices photonServices = PhotonServices();

  PhotonBloc({required this.photonServices}) : super(PhotonInitial()) {
    on<GetSelectionLocation>((event, emit) async {
      emit(AddressListLoading());
      try {
        var selectionAdresses = await photonServices.selectionLocation(
            event.address, event.localeLanguage);
        emit(AddressListLoaded(photonResponse: selectionAdresses));
      } catch (e) {
        // print(e);
      }
    });

    on<GetSelectionAddress>((event, emit) async {
      emit(AddressListLoading());
      try {
        var selectionAdresses =
            await photonServices.selectionAddress(event.coordinates);
        emit(AddressListLoaded(photonResponse: selectionAdresses));
      } catch (e) {
        // print(e);
      }
    });
  }
}
