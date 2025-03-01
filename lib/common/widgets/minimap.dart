import 'package:flutter/cupertino.dart';
import 'package:ar_map_project/common/utils/sizes.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class Minimap extends StatefulWidget {
  const Minimap({super.key});
  @override
  State<Minimap> createState() => _MinimapState();
}

class _MinimapState extends State<Minimap> {

  BorderRadiusGeometry borderRadius = BorderRadius.vertical(top: Radius.circular(ScreenDimensions.width/2.3));
  MapboxMap? mapboxMap;

  _onMapCreated(MapboxMap mapboxMap){
    this.mapboxMap = mapboxMap;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mapboxMap?.location.updateSettings(
      LocationComponentSettings(
        enabled: true,
        locationPuck: LocationPuck(
          locationPuck3D: LocationPuck3D(
            modelUri: 'assets/3d_models/puck.gltf'
          )
        )
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 21),
      height: ScreenDimensions.height*0.3,
      width: ScreenDimensions.width,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: CupertinoColors.activeBlue,
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: MapWidget(
          onMapCreated: _onMapCreated,
          cameraOptions: CameraOptions(
            center: Point(
              coordinates: Position(108.443, 11.955)),
            zoom: 15,
            bearing: 0,
            pitch: 0
          ),
        )
      ),
    );
  }
}