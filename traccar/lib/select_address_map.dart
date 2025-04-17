import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';

import 'photon/photon_test_page.dart';

class SelectAddressMapPage extends StatefulWidget {
  const SelectAddressMapPage({Key? key, required this.startAddress})
      : super(key: key);
  final ValueChanged startAddress;

  @override
  State<SelectAddressMapPage> createState() => _SelectAddressMapPageState();
}

class _SelectAddressMapPageState extends State<SelectAddressMapPage> {
  MapController mapController = MapController();
  List<Marker> markers = [];
  LatLng positionSelected = const LatLng(35.3039, 1.1392);
  final PopupController _userpopupController = PopupController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back,
                  color: Colors.black), // or white, if your background is dark
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
          },
          onPositionChanged: (MapPosition position, bool hasGesture) {
            if (position.center != null) {
              mapController.move(position.center!, mapController.camera.zoom);

              WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
                    positionSelected = position.center!;
                  }));
            }
            if (hasGesture) {
            } else {}
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                widget.startAddress(positionSelected);
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
                      startAddress: (address) {
                        setState(() {
                          widget.startAddress(address);
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
    );
  }
}
