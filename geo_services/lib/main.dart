import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_position_listener/ors/bloc/ors_bloc.dart';
import 'package:gps_position_listener/ors/ors_service.dart';

import 'home_page.dart';
import 'photon/bloc/photon_bloc.dart';
import 'photon/photon_service.dart';

void main() {
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  PhotonServices photonServices = PhotonServices();
  OrsServices orsServices = OrsServices();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PhotonBloc(photonServices: photonServices),
        ),
        BlocProvider(
          create: (context) => OrsBloc(orsServices: orsServices),
        ),
      ],
      child: MaterialApp(
        title: 'GeoServices',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MainPage(),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomePage(),
    );
  }
}
