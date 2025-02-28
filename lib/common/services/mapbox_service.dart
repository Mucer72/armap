import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:ar_map_project/common/models/route_model.dart';
import 'package:ar_map_project/common/models/other_models.dart';
import 'package:image/image.dart' as img;

class MapboxService {
  static const int zoomLevel = 14;
  static String? accessToken = dotenv.env['MAPBOX_TOKEN'];

  static Future<List<Position>> getRoutePositions({
    required Position start,
    required Position end,
    String profile = 'walking',
  }) async {
    List<Position> result = [];
    final url = Uri.parse(
      'https://api.mapbox.com/directions/v5/mapbox/$profile/${start.lng},${start.lat};${end.lng},${end.lat}'
      '?steps=true&access_token=$accessToken',
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      RouteModel route = RouteModel.fromJson(data);
      for (var leg in route.routes.first.legs) {
        for (var step in leg.steps) {
          result.addAll(step.locations);
        }
      }
      for (int i = 0; i < result.length; i++) {
        double? ele = await getElevation(result[i]);
        result[i] = Position(result[i].lng, result[i].lat, ele);
        if (kDebugMode) {
          debugPrint('Check: ${result[i].lng}, ${result[i].lat}, $ele');
        }
      }

      // List<double> elelist = await getElevationList(result);
      // for(int i=0;i<result.length;i++){
      //   if(result[i].alt==0.0){
      //     result[i]=Position(result[i].lng, result[i].lat, elelist[i]);
      //   }
      // }
      return result;
    } else {
      throw Exception('Failed to load route: ${response.statusCode}');
    }
  }


  static TileCoordinate _latLngToTile(Position pos) {
    int x = ((pos.lng + 180) / 360 * math.pow(2, zoomLevel)).floor();
    int y = ((1 - math.log(math.tan(pos.lat * math.pi / 180) +
                  1 / math.cos(pos.lat * math.pi / 180)) /
              math.pi) / 2 * math.pow(2, zoomLevel)).floor();
    return TileCoordinate(x, y, zoomLevel);
  }

  static Position _getPixelCoordinate(Position coordinate, TileCoordinate tile) {
    num longitude = coordinate.lng;
    num latitude = coordinate.lat;
    num xTile = tile.x;
    num yTile = tile.y;
    int tileSize = 256;

  int xPixel = ((longitude + 180) / 360 * math.pow(2, zoomLevel) * tileSize -
          xTile * tileSize).floor();
  int yPixel = ((1 - math.log(math.tan(latitude * math.pi / 180) +
                  1 / math.cos(latitude * math.pi / 180)) /
              math.pi) / 2 * math.pow(2, zoomLevel) * tileSize - yTile * tileSize).floor();

  return Position(xPixel, yPixel);
}

  static Future<void> _downloadTile(TileCoordinate tile) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = "${directory.absolute.path}/tiles/${tile.z}_${tile.x}_${tile.y}.png";
    final file = File(filePath);

    if (await file.exists()) {
      if (kDebugMode) {
        debugPrint("Tile ${tile.z}/${tile.x}/${tile.y} đã tồn tại ở $filePath, bỏ qua tải xuống.");
      }
      return;
    }

    final url = "https://api.mapbox.com/v4/mapbox.terrain-rgb/${tile.z}/${tile.x}/${tile.y}.pngraw?access_token=$accessToken";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      await file.create(recursive: true);
      await file.writeAsBytes(response.bodyBytes);
      if (kDebugMode) {
        debugPrint(url);
        debugPrint("Tile đã tải xuống: $filePath - Kích thước: ${response.bodyBytes.length} bytes");
      }
    } else {
      if (kDebugMode) {
        debugPrint("Lỗi tải tile ${tile.z}/${tile.x}/${tile.y}: ${response.statusCode}");
      }
    }
  }
  static Future<void> checkFileAccess(TileCoordinate tile) async {
  final directory = await getApplicationDocumentsDirectory();
  final filePath = "${directory.path}/tiles/${tile.z}_${tile.x}_${tile.y}.png";
  final file = File(filePath);

  debugPrint("Kiểm tra đường dẫn file: $filePath");

  if (await file.exists()) {
    debugPrint("File tồn tại!");
    try {
      final bytes = await file.readAsBytes();
      debugPrint("File đọc thành công: ${bytes.length} bytes");
    } catch (e) {
      debugPrint("Không thể đọc file: $e");
    }
  } else {
    debugPrint("File không tồn tại!");
  }
}
  static Future<double?> getElevation(Position position) async {
    final tile = _latLngToTile(position);
    final directory = await getApplicationDocumentsDirectory();
    final filePath = "${directory.absolute.path}/tiles/${tile.z}_${tile.x}_${tile.y}.png";
    final file = File(filePath);
    await _downloadTile(tile);
    await checkFileAccess(tile);
    Uint8List bytes = await file.readAsBytes();
    return _decodeElevation(bytes, position, tile);
  }

  static double _decodeElevation(Uint8List bytes, Position position, TileCoordinate tile) {
  int tileSize = 512;

  double latRad = position.lat * math.pi / 180;
  num n = math.pow(2, tile.z);
  double x = ((position.lng + 180.0) / 360.0 * n * tileSize) % tileSize;
  double y = ((1 - math.log(math.tan(latRad) + 1 / math.cos(latRad)) / math.pi) / 2.0 * n * tileSize) % tileSize;

  int px = x.floor().clamp(0, tileSize - 1);
  int py = y.floor().clamp(0, tileSize - 1);
  int pixelIndex = (py * tileSize + px) * 4;

  if (pixelIndex + 3 >= bytes.length) {
    debugPrint("Pixel index out of range: $pixelIndex (max: ${bytes.length})");
    return 0.0;
  }

  int r = bytes[pixelIndex];
  int g = bytes[pixelIndex + 1];
  int b = bytes[pixelIndex + 2];

  double elevation = (r * 256 + g + b / 256.0) - 32768.0;

  debugPrint(" Độ cao tại (${position.lng}, ${position.lat}): $elevation m");
  return elevation;
}

//##pacth
static Future<List<double>> getElevationList(List<Position> points) async {
    List<double> res = [];
    String latlong = '';
    for (Position l in points) {
      String s = '${l.lat},${l.lng}|';
      latlong += s;
    }
    latlong = latlong.substring(0, latlong.length - 1); // Remove the last '|'

    final String url =
    'https://maps.googleapis.com/maps/api/elevation/json?locations=$latlong&key=AIzaSyBrd03LsispwpVkNsXr6geNiVVCNCWO7xY';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {
      final results = data['results'];
      if (results != null) {
      for (var i in results) {
      final double elevation = i['elevation'].toDouble();
      res.add(elevation);
      }
      return res; // Return the elevation data if everything is successful
      }
    }
    }
    // Throw an exception only if there are no results and the status is not 'OK'
    throw Exception('Failed to calculate elevation difference');
  }

}
