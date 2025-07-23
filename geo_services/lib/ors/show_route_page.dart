import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:gps_position_listener/ors/bloc/ors_bloc.dart';
import 'package:latlong2/latlong.dart';

class ShowRoutePage extends StatefulWidget {
  const ShowRoutePage({
    Key? key,
    required this.startAddress,
    required this.endAddress,
  }) : super(key: key);

  final LatLng startAddress;
  final LatLng endAddress;
  @override
  State<ShowRoutePage> createState() => _OrsTestPageState();
}

class _OrsTestPageState extends State<ShowRoutePage> {
  TextEditingController addressController = TextEditingController();
  MapController mapController = MapController();
  List<Marker> markers = [];
  List<LatLng> polyPoints = [];

  @override
  void initState() {
    BlocProvider.of<OrsBloc>(context).add(GetDirections(
        startCoordinates: widget.startAddress,
        endCoordinates: widget.endAddress));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Row(
          children: [
            Text('Route', style: TextStyle(color: Colors.black)),
            Text('  with Ors (direction)',
                style: TextStyle(color: Colors.grey)),
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocListener<OrsBloc, OrsState>(
          listener: (context, state) {
            if (state is OrsDirectionsLoaded) {
              setState(() {
                polyPoints = [];
                for (int i = 0; i < state.lineString.lineString.length; i++) {
                  polyPoints.add(LatLng(state.lineString.lineString[i][1],
                      state.lineString.lineString[i][0]));
                  mapController.move(
                      polyPoints.first, mapController.camera.zoom);
                }
              });
            }
          },
          child: FlutterMap(
            mapController: mapController,
            options: MapOptions(
              initialCenter: widget.startAddress,
              initialZoom: 8,
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.pinchMove |
                    InteractiveFlag.pinchZoom |
                    InteractiveFlag.drag |
                    InteractiveFlag.flingAnimation |
                    InteractiveFlag.doubleTapZoom,
                enableScrollWheel: true,
              ),
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'http://mt0.google.com/vt/lyrs=m&hl=en&x={x}&y={y}&z={z}',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    alignment: Alignment.center,
                    point: widget.startAddress,
                    child: const Icon(
                      Icons.location_on,
                      size: 40,
                      color: Colors.blue,
                    ),
                  ),
                  Marker(
                    alignment: Alignment.center,
                    point: widget.endAddress,
                    child: const Icon(
                      Icons.location_on,
                      size: 40,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              PolylineLayer(
                polylines: [
                  Polyline(
                      points: polyPoints,
                      strokeWidth: 4.0,
                      color: Colors.black),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 100.0, left: 40.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                FloatingActionButton(
                  heroTag: "zoomIn",
                  mini: true,
                  backgroundColor: Colors.white,
                  child: const Icon(Icons.zoom_in, color: Colors.black),
                  onPressed: () {
                    mapController.move(
                      mapController.camera.center,
                      mapController.camera.zoom + 1,
                    );
                  },
                ),
                const SizedBox(height: 8),
                FloatingActionButton(
                  heroTag: "zoomOut",
                  mini: true,
                  backgroundColor: Colors.white,
                  child: const Icon(Icons.zoom_out, color: Colors.black),
                  onPressed: () {
                    mapController.move(
                      mapController.camera.center,
                      mapController.camera.zoom - 1,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
