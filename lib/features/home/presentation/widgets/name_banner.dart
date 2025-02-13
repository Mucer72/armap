import 'package:flutter/cupertino.dart';

import 'package:ar_map_project/common/utils/sizes.dart';

class NameBanner extends StatelessWidget {
  const NameBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenDeimensions.width,
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Text(
        "ar map app",
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold, 
        ),
        ),
      
    );
  }
}