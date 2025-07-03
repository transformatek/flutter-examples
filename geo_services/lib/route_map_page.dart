import 'package:flutter/material.dart';

class RouteMapPage extends StatefulWidget {
  const RouteMapPage({Key? key}) : super(key: key);

  @override
  State<RouteMapPage> createState() => _RouteMapPageState();
}

class _RouteMapPageState extends State<RouteMapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Route"),
      ),
      body: Container(),
    );
  }
}
