import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_position_listener/user_location/bloc/userlocation_listener_bloc.dart';
import 'package:gps_position_listener/user_location/flutter_map_page.dart';
import 'package:gps_position_listener/user_location/home_page.dart';
import 'package:gps_position_listener/user_location/user_location_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final UserLocationService userLocationService = UserLocationService();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserlocationListenerBloc(
              userLocationService: userLocationService),
        ),
      ],
      child: MaterialApp(
        title: 'UserLocationListener',
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
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetsoOption = [
      const MyHomePage(),
      const FlutterMapPage(),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('LOCATION'),
      ),
      body: SafeArea(
        child: widgetsoOption.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: items,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

List<BottomNavigationBarItem> items = [
  const BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
  const BottomNavigationBarItem(icon: Icon(Icons.map), label: ""),
];
