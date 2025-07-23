import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_position_listener/ors/show_route_page.dart';
import 'package:gps_position_listener/photon/bloc/photon_bloc.dart';
import 'package:gps_position_listener/photon/models/address_data.dart';
import 'package:latlong2/latlong.dart';

import 'photon/select_address_map.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AddressData? startAddress;
  AddressData? deliveryAddress;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhotonBloc, PhotonState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(title: const Text("Select Route Addresses")),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 50.0, top: 20.0),
                child: Card(
                  child: ListTile(
                    leading: const Icon(Icons.location_on,
                        color: Colors.blue, size: 30),
                    title: const Text("Start Address"),
                    subtitle: Text(
                      startAddress != null
                          ? startAddress!.properties!.fullAddress
                          : "",
                      style: const TextStyle(color: Colors.blue),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SelectAddressMapPage(
                              initialPosition: startAddress != null
                                  ? LatLng(
                                      startAddress!.geometry!.coordinates![1],
                                      startAddress!.geometry!.coordinates![0],
                                    )
                                  : null,
                              selectAddress: (address) {
                                setState(() {
                                  startAddress = address;
                                });
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  leading:
                      const Icon(Icons.flag, color: Colors.green, size: 30),
                  title: const Text("Delivery Address"),
                  subtitle: Text(
                    deliveryAddress != null
                        ? deliveryAddress!.properties!.fullAddress
                        : "",
                    style: const TextStyle(color: Colors.green),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SelectAddressMapPage(
                            selectAddress: (address) {
                              setState(() {
                                deliveryAddress = address;
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 100.0),
                child: ElevatedButton(
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
                            builder: (context) => ShowRoutePage(
                                  startAddress: startAddress != null &&
                                          startAddress!.geometry != null
                                      ? LatLng(
                                          startAddress!
                                              .geometry!.coordinates![1],
                                          startAddress!
                                              .geometry!.coordinates![0],
                                        )
                                      : const LatLng(35.29749, -1.14037),
                                  endAddress: deliveryAddress != null &&
                                          deliveryAddress!.geometry != null
                                      ? LatLng(
                                          deliveryAddress!
                                              .geometry!.coordinates![1],
                                          deliveryAddress!
                                              .geometry!.coordinates![0],
                                        )
                                      : const LatLng(35.69111, -0.64167),
                                )));
                  },
                  child: const Text("View Route"),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
