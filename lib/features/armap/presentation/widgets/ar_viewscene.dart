import 'package:flutter/cupertino.dart';
import 'package:ar_flutter_plugin_updated/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin_updated/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin_updated/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin_updated/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin_updated/models/ar_node.dart';
import 'package:ar_flutter_plugin_updated/datatypes/node_types.dart';
import 'package:ar_flutter_plugin_updated/widgets/ar_view.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';

class ArViewscene extends StatefulWidget {
  const ArViewscene({super.key});

  @override
  State<ArViewscene> createState() => _ArViewsceneState();
}

class _ArViewsceneState extends State<ArViewscene> {
  
late ARObjectManager arObjectManager;
late ARSessionManager arSessionManager;

  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    this.arSessionManager.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ARView(onARViewCreated: onARViewCreated);
  }

  void onARViewCreated(
    ARSessionManager arSessionManager,
    ARObjectManager arObjectManager,
    ARAnchorManager arAnchorManager,
    ARLocationManager arLocationManager
  ){
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
    this.arObjectManager.addNode(
      ARNode(
        // type: NodeType.fileSystemAppFolderGLB,
        // uri: 'arrow.glb',
        // type: NodeType.webGLB,
        // uri: "https://github.com/Mucer72/armap/raw/main/arrow.glb",
        type: NodeType.localGLTF2,
        uri: "assets/3d_models/scene.gltf",
        scale: Vector3(1, 1, 1),
        position: Vector3(0, 0, 0),
        rotation: Vector4(0, 0, 0.0, 0.0),
        eulerAngles: Vector3(0, 0, 0))
    );
  }
  
}