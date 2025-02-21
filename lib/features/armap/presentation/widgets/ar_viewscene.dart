import 'package:flutter/cupertino.dart';
import 'package:ar_flutter_plugin_updated/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin_updated/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin_updated/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin_updated/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin_updated/models/ar_node.dart';
import 'package:ar_flutter_plugin_updated/widgets/ar_view.dart';
import 'package:flutter/material.dart';

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
  }
}