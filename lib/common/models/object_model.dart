import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class ObjectModel {
  final int id;
  final Position position;
  final int area;
  final String modelType;
  final String description;

  ObjectModel({required this.id, required this.position, required this.area, required this.modelType, required this.description});

  factory ObjectModel.fromJson(Map<String, dynamic> json) {
    return ObjectModel(
      id: json['id'],
      position: json['position'],
      area: json['area'],
      modelType: json['model_type'],
      description: json['description'],
    );
  }
}
