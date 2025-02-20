import 'package:flutter/cupertino.dart';
import 'package:ar_map_project/common/utils/sizes.dart';

class Minimap extends StatefulWidget {
  const Minimap({super.key});

  @override
  State<Minimap> createState() => _MinimapState();
}

class _MinimapState extends State<Minimap> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 21),
      height: ScreenDimensions.height*0.3,
      width: ScreenDimensions.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(ScreenDimensions.width/2.3)),
        color: CupertinoColors.activeBlue,
      ),
      child: Center(
        child: Text("This will be the 2D map"),
      ),
    );
  }
}