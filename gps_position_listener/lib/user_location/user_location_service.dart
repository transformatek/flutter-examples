import 'dart:async';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class UserLocationService {
  late StreamSubscription<LocationData> locationSubscription;
  Location location = Location();
  Future<LatLng> getUserLocation() async {
    LocationData currentPosition;
    bool _serviceEnabled;

    PermissionStatus _permissionGranted;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        throw Exception();
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        throw Exception();
      }
    }
    if (_permissionGranted == PermissionStatus.granted) {
      currentPosition = await location.getLocation();
    }

    currentPosition = await location.getLocation();
    return LatLng(currentPosition.latitude!, currentPosition.longitude!);
  }

  final _positions = StreamController<LatLng>.broadcast();

  /// Get the device positions
  Future<Stream<LatLng>> startListener() async {
    // await location.changeSettings(distanceFilter: 10);
    await location.changeSettings(interval: 3000);
    locationSubscription =
        location.onLocationChanged.listen((LocationData currentLocation) async {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        _positions.sink
            .add(LatLng(currentLocation.latitude!, currentLocation.longitude!));
      }
    });

    return _positions.stream;
  }

  Future<void> dispose() async {
    await _positions.close();
  }

  Future<void> stopListningPostion() async {
    try {
      await locationSubscription.cancel();
    } catch (e) {
      print(e);
    }
  }
}
