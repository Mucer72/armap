import 'package:flutter/foundation.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class LocationHeadingProvider extends ChangeNotifier {
  Position? _currentPosition;
  double _currentHeading = 0.0;

  Position? get currentPosition => _currentPosition;
  double get currentHeading => _currentHeading;

  void updatePosition(Position newPosition) {
    _currentPosition = newPosition;
    notifyListeners();
  }

  void updateHeading(double newHeading) {
    _currentHeading = newHeading;
    notifyListeners();
  }
}