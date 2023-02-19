import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:gps_position_listener/user_location/bloc/userlocation_listener_bloc.dart';
import 'package:latlong2/latlong.dart';

class FlutterMapPage extends StatefulWidget {
  const FlutterMapPage({
    Key? key,
  }) : super(key: key);

  @override
  State<FlutterMapPage> createState() => _FlutterMapPageState();
}

class _FlutterMapPageState extends State<FlutterMapPage> {
  MapController mapController = MapController();
  List<Marker> markers = [];
  @override
  void initState() {
    super.initState();
  }

  LatLng position = LatLng(36.754923, 3.455725);

  @override
  Widget build(BuildContext context) {
    //TODO WRAP WITH USER LOCATION BLOC
    return BlocListener<UserlocationListenerBloc, UserlocationListenerState>(
      listener: (context, state) {
        if (state is LocationLoaded) {
          setState(() {
            position = state.location;
            print(position);
            mapController.move(position, mapController.zoom);
          });
        }
      },
      child: Scaffold(
        body: FlutterMap(
            mapController: mapController,
            options: MapOptions(
              center: position,
              zoom: 12,
              interactiveFlags: InteractiveFlag.pinchMove |
                  InteractiveFlag.pinchZoom |
                  InteractiveFlag.drag |
                  InteractiveFlag.flingAnimation |
                  InteractiveFlag.doubleTapZoom,
              enableScrollWheel: true,
            ),
            layers: [
              TileLayerOptions(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              ),
              MarkerLayerOptions(
                markers: markers,
              )
            ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            BlocProvider.of<UserlocationListenerBloc>(context)
                .add(StopLocationListener());
          },
          tooltip: 'stop',
          child: const Icon(Icons.stop),
        ),
      ),
    );
  }
}
