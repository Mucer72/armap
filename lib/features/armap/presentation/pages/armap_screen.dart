import 'package:ar_flutter_plugin_updated/models/ar_node.dart';
import 'package:ar_map_project/common/models/area_model.dart';
import 'package:ar_map_project/common/providers/location_heading_provider.dart';
import 'package:ar_map_project/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ar_map_project/common/widgets/minimap.dart';
import 'package:ar_map_project/features/armap/presentation/widgets/ar_viewscene.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:ar_map_project/common/services/mapbox_service.dart';
import 'package:ar_map_project/features/armap/presentation/widgets/ar_funcions.dart';
import 'package:provider/provider.dart';
import 'package:vector_math/vector_math_64.dart';

class ArmapScreen extends StatefulWidget {
  const ArmapScreen({super.key});
  @override
  State<ArmapScreen> createState() => _ArmapScreenState();
}

class _ArmapScreenState extends State<ArmapScreen> {
  ARFs arfunctions = ARFs();
  List<ARNode> nodes = [];
  List<Position> points = [];
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    }

  Future<List<ARNode>> getNodes(BuildContext context) async{
    final locHeadProvider = context.read<LocationHeadingProvider>(); // Access the provider
    final currentPosition = locHeadProvider.currentPosition; // Access currentPosition
    final currentHeading = locHeadProvider.currentHeading;
    if (currentPosition == null) {
    // Handle the case where currentPosition is null
      if(kDebugMode){
        debugPrint("Current position is null, cannot get route.");
      }
      return []; // Or throw an exception, or return a default value
    }

    points = await MapboxService.getRoutePositions(
      start: currentPosition, 
      end: Position(108.427716, 11.969926)
    );
    if(kDebugMode){
      for(var point in points){
        debugPrint('load points '+ point.lng.toString()+' '+point.lat.toString()+' '+point.alt.toString());
      }
    }
    return await arfunctions.generateFullRoute(Vector3(0,0,0), currentHeading, points, 0);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getNodes(context), 
      builder: (context, snapshot){
        return Scaffold(
      body: Stack(
        children: [
          Center(child: ArViewscene(nodeList: snapshot.data!)),
          Align(
            alignment: Alignment.bottomCenter,
            child: Minimap(),
          )
        ],
      )
    );
    });
  }
}