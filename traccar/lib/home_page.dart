import 'package:flutter/material.dart';

import 'select_address_map.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String startAddress = "";
  String deliveryAddress = "";

  @override
  Widget build(BuildContext context) {
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
                    startAddress,
                    style: const TextStyle(color: Colors.blue),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SelectAddressMapPage(
                            startAddress: (address) {
                              setState(() {
                                startAddress = address.toString();
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
                leading: const Icon(Icons.flag, color: Colors.green, size: 30),
                title: const Text("Delivery Address"),
                subtitle: Text(
                  deliveryAddress,
                  style: const TextStyle(color: Colors.green),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectAddressMapPage(
                          startAddress: (address) {
                            setState(() {
                              deliveryAddress = address.toString();
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
                onPressed: () {},
                child: const Text("View Route"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
