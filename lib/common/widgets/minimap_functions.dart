import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:ar_map_project/common/models/destination_model.dart';

void addMultipleMarkers(MapboxMap mapboxMap, List<Destination> destinations) async {
  final annotationManager = await mapboxMap.annotations.createPointAnnotationManager();

  List<PointAnnotationOptions> markers = destinations.map((des)=>
    PointAnnotationOptions(
      geometry: Point(coordinates: des.position),
      iconSize: 1.5,
      iconImage: des.imageUrl,
      textField: des.name,
    ),
  ).toList();

  annotationManager.createMulti(markers);
}
