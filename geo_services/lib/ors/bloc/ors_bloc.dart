import 'package:bloc/bloc.dart';
import 'package:gps_position_listener/ors/ors_service.dart';
import 'package:gps_position_listener/ors/utils.dart';
import 'package:latlong2/latlong.dart';
import 'package:meta/meta.dart';

part 'ors_event.dart';
part 'ors_state.dart';

class OrsBloc extends Bloc<OrsEvent, OrsState> {
  OrsServices orsServices = OrsServices();
  OrsBloc({required this.orsServices}) : super(OrsInitial()) {
    on<GetDirections>((event, emit) async {
      emit(OrsDirectionsLoading());
      try {
        var lineString = await orsServices.getRoute(
            event.startCoordinates, event.endCoordinates);
        emit(OrsDirectionsLoaded(lineString: lineString));
      } catch (e) {
        emit(OrsDirectionsError(errorMessage: e.toString()));
      }
    });
  }
}
