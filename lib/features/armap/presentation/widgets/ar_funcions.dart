import 'dart:math';

import 'package:ar_flutter_plugin_updated/models/ar_node.dart';
import 'package:flutter/foundation.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:vector_math/vector_math_64.dart';
import 'package:ar_map_project/common/models/object_models.dart';
import 'package:ar_map_project/common/services/mapbox_service.dart';

class ARFs {
  get http => null;
  MapboxService mapService = MapboxService();
  double degreesToRadians(num degrees) {
    return degrees * pi / 180.0;
  }

  bool pointInPolygon(Position point, List<Position> polygon) {
    int n = polygon.length;
    bool inside = false;

    // Start point for the ray is outside of the polygon
    // Position outsidePoint = Position(point.lat, point.lng + 180);

    for (int i = 0, j = n - 1; i < n; j = i++) {
      if (((polygon[i].lat > point.lat) !=
          (polygon[j].lat > point.lat)) &&
          (point.lng <
              (polygon[j].lng - polygon[i].lng) *
                  (point.lat - polygon[i].lat) /
                  (polygon[j].lat - polygon[i].lat) +
                  polygon[i].lng)) {
        inside = !inside;
      }
    }

    return inside;
  }

  double calculateDistanceInMeters(Position startPosition, Position endPosition) {
    const double earthRadius = 6371.0;
    double startLatRad = degreesToRadians(startPosition.lat);
    double startLngRad = degreesToRadians(startPosition.lng);
    double endLatRad = degreesToRadians(endPosition.lat);
    double endLngRad = degreesToRadians(endPosition.lng);
    double latDiff = endLatRad - startLatRad;
    double lngDiff = endLngRad - startLngRad;
    double a = sin(latDiff / 2) * sin(latDiff / 2) +
        cos(startLatRad) * cos(endLatRad) *
            sin(lngDiff / 2) * sin(lngDiff / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distanceInKilometers = earthRadius * c;
    double distanceInMeters = distanceInKilometers * 1000;

    return distanceInMeters;
  }

  double calculateRotationAngle(Position currentPos, Position destinationPos,
      double currentHeading) {
    double angleToDestination = atan2(
      destinationPos.lng - currentPos.lng,
      destinationPos.lat - currentPos.lat,
    );
    double rotationAngle = degreesToRadians(currentHeading) -
        angleToDestination;
    return rotationAngle;
  }

  Future<List<ARNode>> generateFullRoute(Vector3 anchor, double angle, List<Position> points, int currentStepIndex) async{
    if (currentStepIndex >= points.length - 1) {
      return [];
    }
    await mapService.getElevations(points);
    List<ARNode> nodes = [];
    Position start = points[currentStepIndex];
    Position end = points[currentStepIndex + 1];
    double rotateAngle = calculateRotationAngle(start, end, angle);
    double alpha = pi - rotateAngle;
    Vector3 rotate = Vector3(rotateAngle, 0, 0);
    double d = calculateDistanceInMeters(start, end);
    int numPoints = (d / 3).ceil();
    double elevationDifference = (end.alt!-start.alt!) as double;
    elevationDifference/=numPoints;
    double height = elevationDifference;

    double linearIncrement = d / (numPoints - 1);
    for (int i = 0; i < numPoints; i++) {
      double x = anchor.x - sin(alpha) * linearIncrement * i;
      double y = anchor.y + height;
      double z = anchor.z + cos(alpha) * linearIncrement * i;
      Vector3 position = Vector3(x, y, z);
      height+=elevationDifference;
      ARNode node = ArrowNode(position, rotate);
      if(kDebugMode){
        debugPrint('ehhee' + node.position.toString()+'\n');
      }
      nodes.add(node);
    }
    List<ARNode> nextStepNodes = [];
    if (nodes.isNotEmpty) {
      nextStepNodes = await generateFullRoute(nodes.last.position, angle, points, currentStepIndex + 1);
    }
    nodes.removeAt(nodes.length-1);
    nodes.addAll(nextStepNodes);
    return nodes;
  }


}