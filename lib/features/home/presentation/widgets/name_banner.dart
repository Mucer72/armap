import 'package:flutter/cupertino.dart';

import 'package:ar_map_project/common/utils/sizes.dart';

class NameBanner extends StatelessWidget {
  const NameBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenDimensions.width,
      margin: const EdgeInsets.symmetric(vertical: 52),
      child: const Text(
        "AR MAP APP",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          
        ),
        ),
      
    );
  }
}