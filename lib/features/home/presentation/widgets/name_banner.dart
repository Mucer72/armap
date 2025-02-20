import 'package:flutter/cupertino.dart';

import 'package:ar_map_project/common/utils/sizes.dart';

class NameBanner extends StatelessWidget {
  final String name;
  const NameBanner({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenDimensions.width,
      margin: const EdgeInsets.symmetric(vertical: 52),
      child: Text(
        name,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: CupertinoColors.label ,
          decoration: TextDecoration.none,
        ),
        ),
      
    );
  }
}