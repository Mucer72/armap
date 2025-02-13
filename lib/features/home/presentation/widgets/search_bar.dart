import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:ar_map_project/common/utils/sizes.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CupertinoSearchTextField(),
      width: ScreenDimensions.width*0.9, 
    );
  }
}