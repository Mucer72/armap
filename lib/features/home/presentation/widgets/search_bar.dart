import 'package:flutter/cupertino.dart';

import 'package:ar_map_project/common/utils/sizes.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ScreenDimensions.width*0.9,
      child: const CupertinoSearchTextField(), 
    );
  }
}