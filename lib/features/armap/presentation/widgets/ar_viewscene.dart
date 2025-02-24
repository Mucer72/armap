import 'package:flutter/cupertino.dart';
import 'package:ar_flutter_plugin_updated/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin_updated/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin_updated/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin_updated/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin_updated/models/ar_node.dart';
import 'package:ar_flutter_plugin_updated/datatypes/node_types.dart';
import 'package:ar_flutter_plugin_updated/widgets/ar_view.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:vector_math/vector_math_64.dart';
import 'ar_funcions.dart';

class ArViewscene extends StatefulWidget {
  final double degree;
  final List<Position> points;

  const ArViewscene({super.key, required this.degree, required this.points});

  @override
  State<ArViewscene> createState() => _ArViewsceneState();
}

class _ArViewsceneState extends State<ArViewscene> {
ARFs arf = new ARFs();
late List<ARNode> nodeList; 
late ARObjectManager arObjectManager;
late ARSessionManager arSessionManager;

  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    arSessionManager.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ARView(onARViewCreated: onARViewCreated);
  }

  Future<void> onARViewCreated(
    ARSessionManager arSessionManager,
    ARObjectManager arObjectManager,
    ARAnchorManager arAnchorManager,
    ARLocationManager arLocationManager
  ) async {
    this.arSessionManager = arSessionManager;
    this.arObjectManager = arObjectManager;
    this.arSessionManager.onInitialize(
      showFeaturePoints: false,
      showPlanes: false,
      showWorldOrigin: true,
      handleTaps: true,
      showAnimatedGuide: false,
    );
    this.arObjectManager.onInitialize();
    List<double> elevation = await arf.getElevationList(widget.points);
    nodeList = await arf.generateFullRoute(Vector3(0, 0, 0), widget.degree, widget.points, elevation, 0);
    nodeList.last.uri='des.glb';
    loadObjects(nodeList);
    //arObjectManager.addNode(controller.Controller().arrowNode(Vector3(0.5, 0.5, 0.5), Vector3(10, 0.5, 0.5)));
    this.arObjectManager.onNodeTap = onNodeTapped;
  }
  
  Future<void> onNodeTapped(List<String> nodes) async {
    for(var i in nodes)
    {
      if (i == nodeList.last.name) { // Check if tapped node is the last one (index = length - 1)

        showDialog<void>(
          context: context,
          builder: (BuildContext context) =>
              const AlertDialog(content: Text('Show infor of the building')),
        );
      } else {
        //this.arSessionManager.onError("Tapped arrow node");
      }
    }
  }

  Future<void> loadObjects(List<ARNode> nodeList) async {
    for (ARNode i in nodeList) {
      arObjectManager.addNode(i);
    }
  }
  Future<void> removeObjects(List<ARNode> nodeList) async {
    for (ARNode i in nodeList) {
      arObjectManager.removeNode(i);
    }
  }

}