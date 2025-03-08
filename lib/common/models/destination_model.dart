import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class DestinationModel {
  final int id;
  final int area;
  final String imageUrl;
  final String name;
  final Position position;

  DestinationModel({required this.id, required this.area, required this.imageUrl,  required this.name, required this.position});

  factory DestinationModel.fromJson(Map<String, dynamic> json) {
    return DestinationModel(
      id: json['id'],
      area: json['area'],
      imageUrl: json['imageUrl'],
      name: json['name'],
      position: json['position']
    );
  }
}
