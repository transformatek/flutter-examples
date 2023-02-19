import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_position_listener/user_location/bloc/userlocation_listener_bloc.dart';
import 'package:latlong2/latlong.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  LatLng position = LatLng(36.754923, 3.455725);

  // @override
  // void dispose() {
  //   print("********************");
  //   BlocProvider.of<UserlocationListenerBloc>(context)
  //       .add(StopLocationListener());
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            BlocListener<UserlocationListenerBloc, UserlocationListenerState>(
              listener: (context, state) {
                print(state);
                if (state is LocationLoaded) {
                  setState(() {
                    position = state.location;
                  });
                }
              },
              child: Text(
                "${position.latitude} , ${position.longitude}",
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              onPressed: () {
                BlocProvider.of<UserlocationListenerBloc>(context)
                    .add(StopLocationListener());
              },
              tooltip: 'stop',
              child: const Icon(Icons.stop),
            ),
            FloatingActionButton(
              onPressed: () {
                BlocProvider.of<UserlocationListenerBloc>(context)
                    .add(StartLocationListener());
              },
              tooltip: 'Increment',
              child: const Icon(Icons.play_arrow),
            ),
          ],
        ),
      ),
    );
  }
}
