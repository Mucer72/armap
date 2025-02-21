import 'package:flutter/material.dart';
import 'package:ar_map_project/common/widgets/minimap.dart';
import 'package:ar_map_project/features/armap/presentation/widgets/ar_viewscene.dart';

class ArmapScreen extends StatefulWidget {
  const ArmapScreen({super.key});
  @override
  State<ArmapScreen> createState() => _ArmapScreenState();
}

class _ArmapScreenState extends State<ArmapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(child: ArViewscene()),
          Align(
            alignment: Alignment.bottomCenter,
            child: Minimap(),
          )
        ],
      )
    );
  }
}