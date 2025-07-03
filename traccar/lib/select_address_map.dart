import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:gps_position_listener/photon/bloc/photon_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';

import 'photon/photon_test_page.dart';

class SelectAddressMapPage extends StatefulWidget {
  const SelectAddressMapPage({
    Key? key,
    required this.selectAddress,
    this.initialPosition,
  }) : super(key: key);

  final ValueChanged selectAddress;
  final LatLng? initialPosition;

  @override
  State<SelectAddressMapPage> createState() => _SelectAddressMapPageState();
}

class _SelectAddressMapPageState extends State<SelectAddressMapPage> {
  late LatLng positionSelected;
  MapController mapController = MapController();
  List<Marker> markers = [];
  final PopupController _userpopupController = PopupController();

  @override
  void initState() {
    super.initState();
    positionSelected = widget.initialPosition ?? const LatLng(35.0139, -1.0596);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PhotonBloc, PhotonState>(
      listener: (context, state) {
        if (state is AddressListLoaded) {
          setState(() {
            if (state.photonResponse.addressList.isNotEmpty) {
              var address = state.photonResponse.addressList.first;
              positionSelected = LatLng(
                address.geometry!.coordinates![1],
                address.geometry!.coordinates![0],
              );
              widget.selectAddress(address);
            }
          });
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
        body: FlutterMap(
          mapController: mapController,
          options: MapOptions(
            initialCenter: positionSelected,
            initialZoom: 10,
            interactionOptions: const InteractionOptions(
              flags: InteractiveFlag.pinchMove |
                  InteractiveFlag.pinchZoom |
                  InteractiveFlag.drag |
                  InteractiveFlag.flingAnimation |
                  InteractiveFlag.doubleTapZoom,
              enableScrollWheel: true,
            ),
            onTap: (_, latLng) {
              _userpopupController.hideAllPopups();
              setState(() {
                positionSelected = latLng;
                mapController.move(positionSelected, mapController.camera.zoom);
              });
              BlocProvider.of<PhotonBloc>(context).add(GetSelectionAddress(
                coordinates: positionSelected,
              ));
            },
            onPositionChanged: (MapPosition position, bool hasGesture) {
              if (position.center != null) {
                mapController.move(position.center!, mapController.camera.zoom);

                WidgetsBinding.instance
                    .addPostFrameCallback((_) => setState(() {
                          positionSelected = position.center!;
                        }));
                BlocProvider.of<PhotonBloc>(context).add(GetSelectionAddress(
                  coordinates: positionSelected,
                ));
              }
            },
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            ),
            MarkerLayer(
              markers: [
                Marker(
                  alignment: Alignment.center,
                  point: positionSelected,
                  child: const Icon(
                    Icons.location_on,
                    size: 40,
                    color: Colors.purple,
                  ),
                ),
              ],
            ),
          ],
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
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Confirm Location"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PhotonTestPage(
                        selectAddress: (address) {
                          setState(() {
                            widget.selectAddress(address);

                            positionSelected = LatLng(
                              address.geometry!.coordinates[1],
                              address.geometry!.coordinates[0],
                            );
                            mapController.move(
                              positionSelected,
                              mapController.camera.zoom,
                            );
                            markers = [
                              Marker(
                                alignment: Alignment.center,
                                point: positionSelected,
                                child: const Icon(
                                  Icons.location_on,
                                  size: 40,
                                  color: Colors.green,
                                ),
                              ),
                            ];
                          });
                        },
                      ),
                    ),
                  );
                },
                child: const Text("Enter Address"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
