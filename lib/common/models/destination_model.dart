import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class Destination {
  final Position position;
  final String name;
  final String imageUrl;

  Destination({
    required this.position,
    required this.name,
    required this.imageUrl,
  });

  factory Destination.fromJson(Map<String, dynamic> json) {
    return Destination(
      position: Position.fromJson(json['position']),
      name: json['name'],
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'position': position.toJson(),
      'name': name,
      'image_url': imageUrl,
    };
  }
}