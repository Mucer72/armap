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
          mapOptions: MapOptions(
            pixelRatio: 0.5,
            constrainMode: ConstrainMode.HEIGHT_ONLY,
          ),
          cameraOptions: CameraOptions(
            center: Point(
              coordinates: Position(11.955944656594447, 108.44378138802631)),
            zoom: 20,
            bearing: 0,
            pitch: 0
          ),
        )
      ),
    );
  }
}