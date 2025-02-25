import 'package:ar_flutter_plugin_updated/models/ar_node.dart';
import 'package:flutter/material.dart';
import 'package:ar_map_project/common/widgets/minimap.dart';
import 'package:ar_map_project/features/armap/presentation/widgets/ar_viewscene.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:ar_map_project/common/services/mapbox_service.dart';
import 'package:ar_map_project/features/armap/presentation/widgets/ar_funcions.dart';
import 'package:vector_math/vector_math_64.dart';
class ArmapScreen extends StatefulWidget {
  const ArmapScreen({super.key});
  @override
  State<ArmapScreen> createState() => _ArmapScreenState();
}

class _ArmapScreenState extends State<ArmapScreen> {
  MapboxService mapService = MapboxService();
  ARFs arfunctions = ARFs();
  List<ARNode> nodes = [];
  List<Position> points = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    }

  Future<List<ARNode>> getNodes() async{
    points = await mapService.getRoutePositions(
      start: Position(108.440959, 11.941877), 
      end: Position(108.440509, 11.949308)
    );
    return await arfunctions.generateFullRoute(Vector3(0,0,0), 0, points, 0);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getNodes(), 
      builder: (context, snapshot){
        return Scaffold(
      body: Stack(
        children: [
          Center(child: ArViewscene(nodeList: nodes)),
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