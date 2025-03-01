import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:ar_map_project/common/providers/location_heading_provider.dart';

class StartButton extends StatefulWidget {
  const StartButton({super.key});

  @override
  _StartButtonState createState() => _StartButtonState();
}

class _StartButtonState extends State<StartButton> {
  late StreamSubscription<LocationData> _positionSubscription;
  late StreamSubscription<CompassEvent> _headingSubscription;
  Location loc = Location();
  Position? _latestPosition;
  double? _latestHeading;

  @override
  void initState() {
    super.initState();
    _startListening();
  }

  @override
  void dispose() {
    _positionSubscription.cancel();
    _headingSubscription.cancel();
    super.dispose();
  }

  void _startListening() {
    double fineTune = -4;
    Stream<LocationData> positionStream = loc.onLocationChanged.handleError((dynamic err) {
      if (err is PlatformException) {
        if(kDebugMode){
          debugPrint('Error getting current location: $err');
        }
      }
      _positionSubscription.cancel();
    });
    Stream<CompassEvent>? headingStream = FlutterCompass.events;

    _positionSubscription = positionStream.listen((position) {
      setState(() {
        _latestPosition = Position(position.longitude as num, position.latitude as num);
      });
    });

    _headingSubscription = headingStream!.listen((event) {
      setState(() {
        _latestHeading = (((event.heading!+fineTune)<1?(event.heading!+fineTune)+360:(event.heading!+fineTune))-1).floorToDouble();
      });
    });
  }

  void _updateProvider() {
    if (_latestPosition != null && _latestHeading != null) {
      context.read<LocationHeadingProvider>().updatePosition(_latestPosition!);
      context.read<LocationHeadingProvider>().updateHeading(_latestHeading!);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Position or Heading stream has not emitted yet.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Latest Position: ${_latestPosition?.lat ?? 'N/A'}, ${_latestPosition?.lng ?? 'N/A'}'),
            Text('Latest Heading: ${_latestHeading ?? 'N/A'}'),
            ElevatedButton(
              onPressed: (){
                _updateProvider();
                Navigator.pushNamed(context, '/armap');  
              },
              child: Text('Update Provider'),
            ),
          ],
        ),
    );
  }
}
