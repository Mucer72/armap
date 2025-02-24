import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class MapboxService {
  final String accessToken;

  MapboxService({required this.accessToken});
  Future<List<Position>> getRoutePositions({
    required Position start,
    required Position end,
    String profile = 'walking',
  }) async {
    final url = Uri.parse(
      'https://api.mapbox.com/directions/v5/mapbox/$profile/${start.lng},${start.lat};${end.lng},${end.lat}'
      '?geometries=polyline&access_token=$accessToken',
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final geometry = data['routes'][0]['geometry'];
      final coordinates = _decodePolyline(geometry);
      return coordinates
          .map((coord) => Position(coord[1],coord[0],))
          .toList();
    } else {
      throw Exception('Failed to load route: ${response.statusCode}');
    }
  }

  List<List<double>> _decodePolyline(String encoded) {
    final List<List<double>> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      points.add([lng / 1e5, lat / 1e5]);
    }

    return points;
  }

  Future<void> getElevations(List<Position> positions) async {
    String coordinates = positions
        .map((position) => '${position.lng},${position.lat}')
        .join(';');
    final response = await http.get(
      Uri.parse(
        'https://api.mapbox.com/v4/mapbox.terrain-rgb/tilequery/$coordinates.json?access_token=pk.eyJ1IjoiMjExMTg0NSIsImEiOiJjbTM5Mng4Y2IwdXlxMnZzY3hyamNpNThmIn0.aYzd0SVdic0pzbvFFIuuug',
      ),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      for (var i = 0; i < positions.length; i++) {
        final feature = data['features'][i];
        final r = feature['properties']['r'];
        final g = feature['properties']['g'];
        final b = feature['properties']['b'];

        final elevation = _rgbToElevation(r, g, b);
        positions[i] = Position(positions[i].lat, positions[i].lng, elevation);
      }
    } else {
      throw Exception('Failed to load elevations: ${response.statusCode}');
    }
  }

  double _rgbToElevation(int r, int g, int b) {
    return -10000 + ((r * 256 * 256 + g * 256 + b) * 0.1);
  }

}