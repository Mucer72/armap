import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:ar_map_project/common/models/route_model.dart';
import 'package:ar_map_project/common/models/other_models.dart';

class MapboxService {
  static const int zoomLevel = 15;
  static String? accessToken = dotenv.env['MAPBOX_TOKEN'];
  static Future<List<Position>> getRoutePositions({
    required Position start,
    required Position end,
    String profile = 'walking',
  }) async {
    List<Position> result=[];
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
      for(int i = 0; i < result.length; i++){
        double? ele = await getElevation(result[i]);
        result[i] = Position(result[i].lng, result[i].lat, ele);
        if(kDebugMode)
        {
          debugPrint('check day nha ${result[i].lng}, ${result[i].lat}, $ele');
        }
      }  
      return result;
    } else {
      throw Exception('Failed to load route: ${response.statusCode}');
    }
  }

  static Future<void> downloadTiles(List<Position> boundary) async {
    final tiles = _getTilesFromBoundary(boundary);
    for (var tile in tiles) {
      await _downloadTile(tile);
    }
  }

  static List<TileCoordinate> _getTilesFromBoundary(List<Position> boundary) {
    Set<TileCoordinate> tileSet = {};
    for (var position in boundary) {
      var tile = _latLngToTile(position, zoomLevel);
      tileSet.add(tile);
    }
    return tileSet.toList();
  }

  static TileCoordinate _latLngToTile(Position pos, int zoom) {
    double latRad = pos.lat * (math.pi / 180);
    int n = 1 << zoom;
    int x = ((pos.lng + 180.0) / 360.0 * n).floor();
    int y = ((1.0 - math.log(math.tan(latRad) + 1 / math.cos(latRad)) / math.pi) / 2.0 * n).floor();
    return TileCoordinate(x, y, zoom);
  }

  static List<int> _latLonToTile(Position pos, int zoom) {
    double latRad = pos.lat * (math.pi / 180);
    int n = 1 << zoom;
    int x = ((pos.lng + 180.0) / 360.0 * n).floor();
    int y = ((1.0 - (math.log(math.tan(latRad) + 1 / math.cos(latRad)) / math.pi)) / 2.0 * n).floor();
    return [x, y];
  }

  static Future<void> _downloadTile(TileCoordinate tile) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = "${directory.path}/tiles/${tile.z}_${tile.x}_${tile.y}.png";
    final file = File(filePath);

    // if (await file.exists()) {
    //   if(kDebugMode){
    //     debugPrint("Tile ${tile.z}/${tile.x}/${tile.y} đã tồn tại, bỏ qua tải xuống.");
    //   }
    //   return;
    // }

    final url = "https://api.mapbox.com/v4/mapbox.terrain-rgb/${tile.z}/${tile.x}/${tile.y}.pngraw?access_token=$accessToken";
    if(kDebugMode)
    {
      debugPrint("https://api.mapbox.com/v4/mapbox.terrain-rgb/${tile.z}/${tile.x}/${tile.y}.pngraw?access_token=$accessToken");
    }
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      await file.create(recursive: true);
      await file.writeAsBytes(response.bodyBytes);
      if(kDebugMode){
        debugPrint("Tile ${tile.z}/${tile.x}/${tile.y} đã tải xuống thành công.");
      }
    } else {
      if(kDebugMode){
        debugPrint("Lỗi tải tile ${tile.z}/${tile.x}/${tile.y}: ${response.statusCode}");
      }
      
    }
  }

  static Future<double?> getElevation(Position position) async {
    final tile = _latLngToTile(position, 14);
    final directory = await getApplicationDocumentsDirectory();
    final filePath = "${directory.path}/${tile.z}_${tile.x}_${tile.y}.png";
    final file = File(filePath);
    if (!await file.exists()) return null;

    Uint8List bytes = await file.readAsBytes();
    return _decodeElevation(bytes, position, tile);
  }

  static double _decodeElevation(Uint8List bytes, Position position, TileCoordinate tile) {
    int tileSize = 512; // Mapbox Terrain-RGB mặc định 512x512
    double tileX = ((position.lng + 180) / 360 * tileSize) % tileSize;
    double tileY = ((1 - math.log(math.tan(position.lat * math.pi / 180) + 1 / math.cos(position.lat * math.pi / 180)) / math.pi) / 2 * tileSize) % tileSize;
    
    int pixelIndex = (tileY.floor() * tileSize + tileX.floor()) * 4;
    int r = bytes[pixelIndex];
    int g = bytes[pixelIndex + 1];
    int b = bytes[pixelIndex + 2];
    
    return (r * 256 + g + b / 256) - 32768;
  }
}