import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class RouteModel {
  List<RouteData> routes;

  RouteModel({required this.routes});

  factory RouteModel.fromJson(Map<String, dynamic> json) {
    return RouteModel(
      routes: (json['routes'] as List)
          .map((route) => RouteData.fromJson(route))
          .toList(),
    );
  }
}

class RouteData {
  List<Leg> legs;

  RouteData({required this.legs});

  factory RouteData.fromJson(Map<String, dynamic> json) {
    return RouteData(
      legs: (json['legs'] as List)
          .map((leg) => Leg.fromJson(leg))
          .toList(),
    );
  }
}

class Leg {
  List<StepData> steps;

  Leg({required this.steps});

  factory Leg.fromJson(Map<String, dynamic> json) {
    return Leg(
      steps: (json['steps'] as List)
          .map((step) => StepData.fromJson(step))
          .toList(),
    );
  }
}

class StepData {
  List<Position> locations;

  StepData({required this.locations});

  factory StepData.fromJson(Map<String, dynamic> json) {
    List<dynamic> intersections = json['intersections'] ?? [];
    
    List<Position> positions = intersections.map((intersection) {
      var loc = intersection['location'];
      return Position(loc[0], loc[1]); // lng, lat
    }).toList();

    return StepData(locations: positions);
  }
}
