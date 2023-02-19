import 'package:bloc/bloc.dart';
import 'package:gps_position_listener/user_location/user_location_service.dart';
import 'package:latlong2/latlong.dart';
import 'package:meta/meta.dart';

part 'userlocation_listener_event.dart';
part 'userlocation_listener_state.dart';

class UserlocationListenerBloc
    extends Bloc<UserlocationListenerEvent, UserlocationListenerState> {
  UserLocationService userLocationService = UserLocationService();
  UserlocationListenerBloc({required this.userLocationService})
      : super(UserlocationListenerInitial()) {
    on<StartLocationListener>((event, emit) async {
      return emit.forEach(
        await userLocationService.startListener(),
        onData: (location) {
          print(location);
          return LocationLoaded(location: location as LatLng);
        },
      );
    });
    on<StopLocationListener>((event, emit) async {
      userLocationService.stopListningPostion();
    });
  }
}
